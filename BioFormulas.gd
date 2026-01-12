# BioFormulaHub.gd
# Centralizes all biological, metabolic, and progression math.
extends Node
class_name BioFormulaHub

# =================================================================
# CONSTANTS & CONFIGURATION
# =================================================================

# --- Stomach Mechanics (PDF 1 / PDF 10) ---
const STOMACH_ABS_MAX: float = 4000.0
const STOMACH_ABS_MIN_MAX: float = 2000.0
const STOMACH_ABS_MIN_MIN: float = 50.0
const STOMACH_DEATH_OVERFILL: float = 50.0

# --- Muscle & Fat Mechanics (PDF 1 / PDF 10) ---
const MUSCLE_CREATION_CAP_KCAL: float = 3500.0 # Max muscle gain per day
const FAT_BURN_RATIO: float = 3.0 # 3:1 Muscle:Fat burn ratio during deficit
const KCAL_PER_KG_MUSCLE: float = 3500.0 # Roughly derived from weight/cal stats

# --- Body Composition ---
const BASE_HEIGHT_WEIGHT_BMI: float = 21.5 # Median Avg for generation

# =================================================================
# SHORT-TERM METABOLISM (Per Tick/Turn)
# Handles Digestion, Immediate Burn, and Starvation checks
# =================================================================
static func process_metabolic_tick(char_data: Character, delta_turns: int) -> void:
	# 1. Calculate Burn (BBR + Encumbrance - calculated externally)
	# Placeholder: Using Base Sedentary Rate (PDF 9: 0.017 kcal/turn)
	# In full sim, pass 'current_activity_burn_rate' as an argument or fetch from char state
	var burn_rate_per_turn = GameConstants.BASE_SEDENTARY_BURN_RATE_KCAL_PER_TURN 
	var total_burn = burn_rate_per_turn * delta_turns
	
	# 2. Digestion (Stomach -> Reserves)
	# Logic: Convert stomach contents to available energy (Reserves)
	# Rate: Should vary by food type (Carb vs Fat), using generic 0.1 for now
	var digestion_cap = 0.1 * delta_turns
	var calories_digested = min(char_data.current_satiation_ml, digestion_cap)
	
	# Remove from stomach
	char_data.current_satiation_ml = max(0.0, char_data.current_satiation_ml - calories_digested)
	
	# 3. Energy Balance & Self-Correction
	var energy_balance = calories_digested - total_burn
	
	if energy_balance > 0:
		# SURPLUS:
		# Immediate surplus goes to Reserves (Fat)
		# Muscle synthesis happens in the Long-Term update based on activity triggers
		char_data.current_reserve_value_crv_kcal += energy_balance
		
	else:
		# DEFICIT:
		# Logic: Burn Reserves (Fat) and Converted (Muscle) based on 3:1 ratio (PDF 10)
		var deficit = abs(energy_balance)
		
		# 3 parts Muscle, 1 part Fat = 4 parts total
		var fat_loss_ratio = 1.0 / (FAT_BURN_RATIO + 1.0)    # 0.25
		var muscle_loss_ratio = FAT_BURN_RATIO / (FAT_BURN_RATIO + 1.0) # 0.75
		
		var fat_loss = deficit * fat_loss_ratio
		var muscle_loss = deficit * muscle_loss_ratio
		
		# Apply Loss with floor clamp
		char_data.current_reserve_value_crv_kcal = max(0.0, char_data.current_reserve_value_crv_kcal - fat_loss)
		char_data.current_converted_value_ccv_kcal = max(0.0, char_data.current_converted_value_ccv_kcal - muscle_loss)

	# 4. Mark Character for Stat Recalculation
	char_data.mark_dirty()

# =================================================================
# LONG-TERM METABOLISM (Daily/Weekly Processing)
# Handles Stomach Elasticity, Skill Decay, and Muscle Growth/Atrophy
# =================================================================
static func process_daily_cycle(character_data: Character, daily_avg_fill: float):
	# --- Stomach Capacity Logic ---
	# Expand if full, shrink if empty
	if daily_avg_fill >= character_data.stomach_max_cap:
		character_data.stomach_max_cap = min(character_data.stomach_max_cap + 50.0, STOMACH_ABS_MAX)
	else:
		character_data.stomach_max_cap = max(character_data.stomach_max_cap - 25.0, STOMACH_ABS_MIN_MAX)
	
	if daily_avg_fill < character_data.stomach_min_cap:
		character_data.stomach_min_cap = max(character_data.stomach_min_cap - 10.0, STOMACH_ABS_MIN_MIN)
	
	# Death Check (Rupture)
	if daily_avg_fill > character_data.stomach_max_cap + STOMACH_DEATH_OVERFILL:
		character_data.die("Stomach Rupture")

	# Daily skill decay lookup
	apply_daily_skill_decay(character_data)

# To be called by the TimeManager at end of day/week
static func update_long_term_muscle_mass(
	char_data: Character, 
	daily_heavy_activity_kcal: float, 
	daily_carry_weight_kg: float,
	weekly_sedentary_min: float, 
	weekly_heavy_min: float, 
	weekly_moderate_min: float
) -> void:
	
	# --- 1. MUSCLE LOSS (Atrophy) LOGIC ---
	# Formula: [Sedentary - Heavy] * [Moderate * 0.1]
	var activity_diff = weekly_sedentary_min - weekly_heavy_min
	var moderate_factor = weekly_moderate_min * 0.1
	
	# The "Atrophy Force"
	var muscle_loss_factor = activity_diff * moderate_factor
	
	if muscle_loss_factor > 0:
		# If Sedentary outweighs Heavy, we lose muscle.
		# We treat the factor as Kcal of muscle tissue to remove.
		char_data.current_converted_value_ccv_kcal = max(
			0.0, 
			char_data.current_converted_value_ccv_kcal - muscle_loss_factor
		)
	
	# --- 2. MUSCLE GAIN (Hypertrophy) LOGIC ---
	# Trigger: High heavy activity + Carry Weight
	# Constraint: Can only gain if there are Reserves (Fat) to convert (Surplus state)
	
	# Calculate Stimulus Score
	var carry_ratio = 0.0
	# Check carry capacity to avoid divide_by_zero (Getter from Character.gd)
	var carry_cap = char_data.get_stat_carry_capacity() 
	if carry_cap > 0:
		carry_ratio = daily_carry_weight_kg / carry_cap
		
	var stimulus_score = (daily_heavy_activity_kcal / 500.0) + carry_ratio
	
	# Threshold check: Did they work hard enough to trigger growth?
	if stimulus_score > 1.5: # Threshold constant
		# Calculate how much we CAN grow
		# Growth is fuel dependent. We convert Fat (Reserves) into Muscle (Converted)
		
		var available_reserves = char_data.current_reserve_value_crv_kcal
		
		if available_reserves > 0:
			# Base gain based on stimulus, hard capped by Biological Limit (3500 kcal)
			var growth_potential = stimulus_score * 100.0 # e.g. 1.5 * 100 = 150 kcal muscle gain
			var actual_gain = min(growth_potential, MUSCLE_CREATION_CAP_KCAL)
			
			# Ensure we don't use more fat than we have
			actual_gain = min(actual_gain, available_reserves)
			
			# Apply Conversion
			char_data.current_reserve_value_crv_kcal -= actual_gain
			char_data.current_converted_value_ccv_kcal += actual_gain

	char_data.mark_dirty()

# =================================================================
# XP & SKILLS
# =================================================================
static func calculate_xp_gain(base_amount: float, aptitude: float, potential: float) -> float:
	# Normalized Aptitude: 0-100 score provides 1x to 5x multiplier
	var apt_mult = clamp(1.0 + (aptitude / 25.0), 1.0, 5.0)
	return base_amount * potential * apt_mult

static func apply_daily_skill_decay(character_data: Character):
	# Muscle Memory reduces decay
	var mm_modifier = 1.0 - (character_data.get_stat_muscle_memory() / 100.0)
	
	for key in character_data.skills:
		var sk = character_data.skills[key]
		# FIX: Assuming get_total_turns_passed() is a static function or variable in GameConstants
		var turns_since_use = GameConstants.get_total_turns_passed - sk["last_used_turn"]
		
		# Only decay if not used for a week
		if turns_since_use < GameConstants.TURNS_PER_WEEK: 
			continue
		
		var decay_rate = GameConstants.BASE_SKILL_DECAY_RATE
		# Double decay if not used for a month
		if turns_since_use >= GameConstants.TURNS_PER_MONTH: 
			decay_rate *= 2.0
		
		# Apply decay buffered by Muscle Memory
		sk["proficiency"] = max(1.0, sk["proficiency"] - (decay_rate * mm_modifier))

# =================================================================
# HELPER MATH (BMI & DENSITY)
# =================================================================
static func calculate_bmi(weight: float, height_cm: float) -> float:
	var height_m = height_cm / 100.0
	return (weight / (height_m * height_m)) * 10000.0 # Multiplier for CM input
	
# A static helper function for calculating weight from volume and density
# Note: Density must be provided in kg/mL (e.g., water is approx 0.001 kg/mL)
static func calculate_liquid_weight_from_volume(volume_ml: float, density_kg_per_ml: float) -> float:
	# Weight = Volume (mL) x Density
	return volume_ml * density_kg_per_ml
