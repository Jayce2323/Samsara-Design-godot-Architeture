#Tracked Coonsts

extends Node

class_name GameConstants

# =================================================================
# CONSTANTS (Static Formulas and Data Lookups)
# =================================================================

# --- TIME CONSTANTS (1 game turn = 1.2 sec) ---
var total_turns_passed: int = 0
const TURN_DURATION_REAL_SECONDS: float = 1.2
const TURNS_PER_MINUTE: int = 50 
const TURNS_PER_HOUR: int = 3000
const TURNS_PER_DAY: int = 72000
const TURNS_PER_WEEK: int = TURNS_PER_DAY * 7      # 504,000 turns
const TURNS_PER_2_WEEKS: int = TURNS_PER_WEEK * 2 # 1,008,000 turns
const TURNS_PER_MONTH: int = TURNS_PER_DAY * 30    # 2,160,000 turns


# --- METABOLISM & WEIGHT CONSTANTS ---
const KCAL_PER_POUND: float = 3500.0
const KCAL_PER_KG: float = 7716.18 
const BASE_SEDENTARY_BURN_RATE_KCAL_PER_TURN: float = 0.017 # approx 1 per minute / 0.017 per sec
const BASE_LIGHT_BURN_RATE_KCAL_PER_TURN: float = 0.051 # approx 3 per minute/  .051 per sec
const BASE_MODERATE_BURN_RATE_KCAL_PER_TURN: float = 0.084 # approx 5 per minute / 0.084 per sec
const BASE_HEAVY_BURN_RATE_KCAL_PER_TURN: float = 0.2 # approx 12 per minute / 0.2 per sec
const MUSCLE_FAT_BURN_RATIO: float = 3.0 # 3 parts muscle burned for every 1 part fat
const NATURAL_CAP_KCAL_TRANSFER_PER_DAY: float = 3500.0

# --- BASE CHARACTER HEALTH PART VALUES (per number of parts) ---
const BODY_PART_HP_MAP: Dictionary = {
	GameTypes.BodyPart.HEAD: 42.5, # 25 parts
	GameTypes.BodyPart.TORSO: 56.1, # 33 parts
	GameTypes.BodyPart.R_ARM: 27.2,   # 16 parts
	GameTypes.BodyPart.L_ARM: 27.2,   # 16 parts
	GameTypes.BodyPart.R_HAND: 20.4,  # 12 parts
	GameTypes.BodyPart.L_HAND: 20.4, # 12 parts
	GameTypes.BodyPart.R_LEG: 27.2,   # 16 parts
	GameTypes.BodyPart.L_LEG: 27.2,   # 16 parts
	GameTypes.BodyPart.R_FOOT: 20.4,  # 12 parts
	GameTypes.BodyPart.L_FOOT: 20.4,  # 12 parts
	}


# Static internal weights as percentages of bodyweight (BW)
const SKELETAL_MALE_PCT: float = 0.15
const SKELETAL_FEMALE_PCT: float = 0.12
const ORGAN_WEIGHT_PCT: float = 0.25
const BASE_FLUID_COMP_PCT: float = 0.02
const STARVATION_PENALTY_MUSCLE_PCT_THRESHOLD: float = 0.15 # <15% bodyweight character has physical starvation penalties

# Satiation Rating by volume
const SATIATION_RATING: Dictionary = {
	GameTypes.SatiationLevel.STARVING: [0.00, 50],
	GameTypes.SatiationLevel.HUNGRY: [51, 100],
	GameTypes.SatiationLevel.PECKISH: [101, 300],
	GameTypes.SatiationLevel.MILD_FULLNESS: [301, 550], 
	GameTypes.SatiationLevel.SATIATED: [551, 800], 
	GameTypes.SatiationLevel.COMFORTABLY_FULL: [801, 1500], 
	GameTypes.SatiationLevel.STUFFED: [1501, 2000], 
	GameTypes.SatiationLevel.BURSTING: [2001, 4000]
	}
# Macronutrient Absorption Rates (kcal/hr)
const MACRO_ABSORPTION_KCAL_HR: Dictionary = {
	"CARBS_SIMPLE": 240.0,
	"CARBS_COMPLEX": 390.0,
	"FATS": 9.0,
	"PROTEIN_LEAN": 36.0,
	"PROTEIN_FATTY": 12.0
}

# Stomach Capacity (mL)
const STOMACH_CAPACITY: Dictionary = {
	"MIN_STARTING": 75.0,
	"MAX_CAP": 2750.0 # 2.75L
	}

# Daily_Decay_Rate = (1.0 / 14 days) = approx 0.0714 proficiency per day
const BASE_SKILL_DECAY_RATE: float = 1.0 / 14.0  # Adjust this value based on your balance needs

# --- LIQUID CONVERSION & DENSITY ---
const ML_PER_DRAM: float = 3.69
const DRAM_PER_ML: float = 0.271 # Inverse for clarity, derived from 1 mL = 0.271 Dram

# Helper to safely increment the turn counter
static func add_turn():
	# Because GameConstants is an Autoload (singleton node), we can modify its instance variables safely
	var gc_instance = Engine.get_main_loop().get_node("GameConstants") 
	if gc_instance:
		gc_instance.total_turns_passed += 1

# Helper to safely retrieve the current turn count
static func get_total_turns_passed() -> int:
	var gc_instance = Engine.get_main_loop().get_node("GameConstants")
	if gc_instance:
		return gc_instance.total_turns_passed
	return 0
