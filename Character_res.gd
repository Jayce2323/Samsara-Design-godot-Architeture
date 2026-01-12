#BaseClass for Characterbuilding
extends Resource

class_name Character

# =================================================================
# IDENTIFICATION & BASE ATTRIBUTES (Set in Editor or Character Creation UI)
# =================================================================

@export var character_name: String = "New Character"
@export var character_gender: GameTypes.Gender = GameTypes.Gender.MALE
@export var height_cm: float = 175.0 
@export var stomach_max_cap: float = 2750.0
@export var stomach_min_cap: float = 75.0
@export var inventory: Inventory = preload("res://Resources/Inventory_Res/PlayerInventory.tres") # Preload a default or new inventory resource

# =================================================================
# CURRENT DYNAMIC STATE (Track character status during gameplay)
# =================================================================

# Health/Combat State
var current_total_health: float = 0.0
var current_stamina_points: float = 0.0
var current_vigor_points: float = 0.0 # Qi/Ki/Chakra
var fatigue_points: int = 0
var limb_health: Dictionary = {} # Stores HP for head, torso, arms, etc.

# Performance Caching
var _stats_dirty: bool = true
var _cached_attr_strength: float = 0.0
var _cached_attr_intelligence: float = 0.0
var _cached_attr_endurance: float = 0.0
var _cached_attr_dexterity: float = 0.0
var _cached_attr_willpower: float = 0.0
var _cached_attr_perception: float = 0.0

# Metabolism State
var current_satiation_ml: float = GameConstants.STOMACH_CAPACITY["MIN_STARTING"] # move Stomachcap from const -to types
var current_reserve_value_crv_kcal: float = 0.0 # Current Body Fat (kcals)
var current_converted_value_ccv_kcal: float = 0.0 # Current Muscle Mass (kcals)
var current_weight_kg: float = 0.0 # Dynamic total weight

# --- Skill Container ---
# Stores: { SkillKey: { "proficiency": float, "knowledge": float, "potential": float } }
@export var skills: Dictionary = {}

# =================================================================
# INITIALIZATION (Call this when creating a NEW character instance)
# =================================================================

func initialize_starting_state():
	current_weight_kg = calculate_base_starting_weight_kg()
	# Initialize health and stamina pools based on starting weight/attributes
	#current_total_health = get_max_total_health_points()
	#current_stamina_points = get_max_stamina_points()
	
	# Initialize health using GameConstants map
	for part in GameConstants.BODY_PART_HP_MAP:
		limb_health[part] = GameConstants.BODY_PART_HP_MAP[part]

	initialize_skills()
	mark_dirty()

func initialize_skills():
	if skills.is_empty():
		for key in GameTypes.SkillKey.values():
			skills[key] = {
				"proficiency": 1.0, 
				"knowledge": 1.0, 
				"potential": 1.0,
				"last_used_turn": 0 # Track when this skill was last exercised
				}

func use_skill(skill_key: GameTypes.SkillKey):
	if skills.has(skill_key):
		# FIX: Access turns via a helper function in GameConstants Autoload
		skills[skill_key]["last_used_turn"] = GameConstants.get_total_turns_passed()
		mark_dirty() # Mark stats dirty as skill change affects attributes

# Split logic for L/R eyes
func get_vision_integrity() -> float:
	return (get_integrity(GameTypes.BodyPart.L_EYE) + get_integrity(GameTypes.BodyPart.R_EYE)) / 2.0

func get_bmi() -> float:
	# BMI Formula= [Weight/(Height x Height)] x 10,000
	var height_m = height_cm / 100.0
	return (current_weight_kg / (height_m * height_m)) * 10000.0
	
func calculate_base_starting_weight_kg() -> float:
	# [Starting Weight = 21.5 x (Height in meters x Height in meters)]
	var height_m = height_cm / 100.0
	return BioFormulaHub.BASE_HEIGHT_WEIGHT_BMI * (height_m * height_m)

# --- Integrity Getter (Use this function everywhere for integrity checks) ---
# Dynamically calculates integrity from health data based on max HP from GameConstants
func get_integrity(part: GameTypes.BodyPart) -> float:
	var current_hp = limb_health.get(part, -1.0)
	if current_hp < 0: return 1.0 # Assume full health if not tracked
	var max_hp = GameConstants.BODY_PART_HP_MAP.get(part, 1.0)
	return clamp(current_hp / max_hp, 0.0, 1.0)
	
# =================================================================
# STAT AGGREGATION (Skill Proficiency -> Stat Value)
# =================================================================

# Helper to get the proficiency value of a skill safely
func _get_p(skill_key: GameTypes.SkillKey) -> float:
	# NOTE: Add on-the-fly decay check here later if needed
	if skills.has(skill_key):
		return skills[skill_key]["proficiency"]
	return 0.0

# Example: Power = Combat(17%) + Agric(30%) + Stone(30%) + Athl(20%) + Metal(22.5%)
func get_stat_power() -> float:
	return (_get_p(GameTypes.SkillKey.COMBAT) * 0.17) + \
		   (_get_p(GameTypes.SkillKey.AGRICULTURE) * 0.30) + \
		   (_get_p(GameTypes.SkillKey.STONEWORKING) * 0.30) + \
		   (_get_p(GameTypes.SkillKey.ATHLETICS) * 0.20) + \
		   (_get_p(GameTypes.SkillKey.METALLURGY) * 0.225)

func get_stat_accuracy() -> float:
	return (_get_p(GameTypes.SkillKey.COMBAT) * 0.17) + \
		   (_get_p(GameTypes.SkillKey.SURVIVAL) * 0.25) + \
		   (_get_p(GameTypes.SkillKey.STONEWORKING) * 0.30) + \
		   (_get_p(GameTypes.SkillKey.ROGUERY) * 0.35) + \
		   (_get_p(GameTypes.SkillKey.ATHLETICS) * 0.15) + \
		   (_get_p(GameTypes.SkillKey.ARTISTRY) * 0.40)
		
func get_stat_stamina()-> float:
	return (_get_p(GameTypes.SkillKey.COMBAT) * 0.0165) + \
		   (_get_p(GameTypes.SkillKey.SURVIVAL) * 0.25) + \
		   (_get_p(GameTypes.SkillKey.AGRICULTURE) * 0.40) + \
		   (_get_p(GameTypes.SkillKey.STONEWORKING) * 0.40) + \
		   (_get_p(GameTypes.SkillKey.ATHLETICS) * 0.15) + \
		   (_get_p(GameTypes.SkillKey.METALLURGY) * 0.225) + \
		   (_get_p(GameTypes.SkillKey.ARTISTRY) * 0.10)
		
func get_stat_toughness()-> float:
	return (_get_p(GameTypes.SkillKey.COMBAT) * .0165) + \
		   (_get_p(GameTypes.SkillKey.SURVIVAL) * 0.25) + \
		   (_get_p(GameTypes.SkillKey.AGRICULTURE) * 0.20) + \
		   (_get_p(GameTypes.SkillKey.METALLURGY) * 0.225)
		
func get_stat_quickness()-> float:
	return (_get_p(GameTypes.SkillKey.COMBAT) * .0165) + \
		   (_get_p(GameTypes.SkillKey.ATHLETICS) * 0.20)
		
func get_stat_muscle_memory()-> float:
	return (_get_p(GameTypes.SkillKey.COMBAT) * .0165) + \
		   (_get_p(GameTypes.SkillKey.AGRICULTURE) * 0.10) + \
		   (_get_p(GameTypes.SkillKey.ATHLETICS) * 0.10) + \
		   (_get_p(GameTypes.SkillKey.METALLURGY) * 0.10)
		
func get_stat_resilience()-> float:
	return (_get_p(GameTypes.SkillKey.SURVIVAL) * 0.25) + \
		   (_get_p(GameTypes.SkillKey.ATHLETICS) * 0.10) + \
		   (_get_p(GameTypes.SkillKey.METALLURGY) * 0.225)
		
func get_stat_aptitude()-> float:
	return (_get_p(GameTypes.SkillKey.ROGUERY) * 0.30) + \
		   (_get_p(GameTypes.SkillKey.LEARNING) * 1.00) + \
		   (_get_p(GameTypes.SkillKey.SPEECH) * 0.50) + \
		   (_get_p(GameTypes.SkillKey.ARTISTRY) * 0.50)
		
func get_stat_charisma()-> float:
	return (_get_p(GameTypes.SkillKey.ROGUERY) * 0.35) + \
		   (_get_p(GameTypes.SkillKey.ATHLETICS) * 0.10) + \
		   (_get_p(GameTypes.SkillKey.SPEECH) * 0.50)
		
func get_stat_constitution()-> float:
	return (_get_p(GameTypes.SkillKey.CONTROL) * 1.00)

# =================================================================
# ATTRIBUTE AGGREGATION (Stat Value -> Attribute)
# =================================================================
# Use caching logic for performance

func mark_dirty():
	_stats_dirty = true # Call this whenever health or skills change

func get_attr_strength() -> float:
	if _stats_dirty: _recalculate_all_attributes()
	return _cached_attr_strength

func get_attr_intelligence() -> float:
	if _stats_dirty: _recalculate_all_attributes()
	return _cached_attr_intelligence

func get_attr_endurance() -> float:
	if _stats_dirty: _recalculate_all_attributes()
	return _cached_attr_endurance
	
func get_attr_dexterity() -> float:
	if _stats_dirty: _recalculate_all_attributes()
	return _cached_attr_dexterity
	
func get_attr_willpower() -> float:
	if _stats_dirty: _recalculate_all_attributes()
	return _cached_attr_willpower
	
func get_attr_perception() -> float:
	if _stats_dirty: _recalculate_all_attributes()
	return _cached_attr_perception

func _recalculate_all_attributes():
	# Str- Power 40%, Stamina 40%, Toughness 20%
	var str_base = (get_stat_power() * 0.40) + (get_stat_stamina() * 0.40) + (get_stat_toughness() * 0.20)
	# Weighting by body parts: Torso 50%, Arms 20%, Legs 30%
	# (Assuming limb_integrity is 0.0 to 1.0 based on damage)
	var str_body_mod = (get_integrity(GameTypes.BodyPart.TORSO) * 0.50) + \
				   (get_integrity(GameTypes.BodyPart.L_ARM) * 0.10) + \
				   (get_integrity(GameTypes.BodyPart.R_ARM) * 0.10) + \
				   (get_integrity(GameTypes.BodyPart.L_LEG) * 0.15) + \
				   (get_integrity(GameTypes.BodyPart.R_LEG) * 0.15)
	_cached_attr_strength = str_base * str_body_mod
# Int- Charisma 10%, Muscle Memory 20%, Aptitude 70%
	var int_base = (get_stat_stamina() * 0.50) + (get_stat_muscle_memory() * 0.20) + (get_stat_aptitude() * 0.70)
	var int_body_mod = (get_integrity(GameTypes.BodyPart.HEAD) * 1.00)
	_cached_attr_intelligence = int_base * int_body_mod
# End- Charisma 10%, Muscle Memory 20%, Aptitude 70%
	var end_base = (get_stat_stamina() * 0.50) + (get_stat_muscle_memory() * 0.15) + (get_stat_quickness() * 0.15) + (get_stat_constitution() * 0.20)
	var end_body_mod = (get_integrity(GameTypes.BodyPart.MUSCLE) * 0.33) + \
					(get_integrity(GameTypes.BodyPart.LUNGS) * 0.33) +\
					(get_integrity(GameTypes.BodyPart.FAT) * 0.33)
	_cached_attr_endurance = end_base * end_body_mod
# Dex- Charisma 10%, Muscle Memory 20%, Aptitude 70%
	var dex_base = (get_stat_accuracy() * 0.50) + (get_stat_quickness() * 0.25) + (get_stat_muscle_memory() * 0.25)
	var dex_body_mod = (get_integrity(GameTypes.BodyPart.EYES) * 0.50) + \
					(get_integrity(GameTypes.BodyPart.L_HAND) * 0.25) + \
					(get_integrity(GameTypes.BodyPart.R_HAND) * 0.25)
	_cached_attr_dexterity =  dex_base * dex_body_mod
	# Will- Charisma 10%, Muscle Memory 20%, Aptitude 70%
	var will_base = (get_stat_toughness() * 0.25) + (get_stat_resilience() * 0.25) + (get_stat_aptitude() * 0.20) + (get_stat_constitution() * 0.30)
	var will_body_mod = (get_integrity(GameTypes.BodyPart.BRAIN) * 1.00)
	_cached_attr_willpower =  will_base * will_body_mod
# Per- Charisma 10%, Muscle Memory 20%, Aptitude 70%
	var per_base = (get_stat_accuracy() * 0.50) + (get_stat_charisma() * 0.20) + (get_stat_resilience() * 0.15) + (get_stat_aptitude() * 0.15)
	var per_body_mod = (get_integrity(GameTypes.BodyPart.EYES) * 0.50) + \
				   (get_integrity(GameTypes.BodyPart.L_EAR) * 0.10) + \
				   (get_integrity(GameTypes.BodyPart.R_EAR) * 0.10) + \
				   (get_integrity(GameTypes.BodyPart.NOSE) * 0.15) + \
				   (get_integrity(GameTypes.BodyPart.SKIN) * 0.15)
	_cached_attr_perception = per_base * per_body_mod
	_stats_dirty = false

 #Add XP to a specific skill
func add_skill_xp(skill_key: GameTypes.SkillKey, amount: float):
	if not skills.has(skill_key): return
	
	var sk = skills[skill_key]
 	# Use FormulaHub calculation with normalized aptitude
	var total_gain = BioFormulaHub.calculate_xp_gain(amount, get_stat_aptitude(), sk.get("potential", 1.0))
	
	sk["knowledge"] += total_gain 
	if sk["proficiency"] < sk["knowledge"]:
		sk["proficiency"] = move_toward(sk["proficiency"], sk["knowledge"], total_gain * 0.5)
	
	use_skill(skill_key) # Mark skill as used, marks stats dirty

# Exponential XP Calculation for UI/Levels
func get_xp_needed(level: int) -> int:
	const BASE_XP = 100
	const EXP_FACTOR = 1.5
	return int(BASE_XP * (level * EXP_FACTOR))

func end_player_turn():
	GameConstants.get_total_turns_passed()
