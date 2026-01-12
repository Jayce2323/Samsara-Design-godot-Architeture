#CharacterEnums

extends Node

class_name GameTypes

# =================================================================
# ENUMS (Centralized type definitions for keys/identifiers)
# =================================================================

enum Gender { MALE, FEMALE }
enum StatKey { STRENGTH, INTELLIGENCE, ENDURANCE, DEXTERITY, WILLPOWER, PERCEPTION, 
	HEIGHT, POWER, ACCURACY, CHARISMA, STAMINA, TOUGHNESS, QUICKNESS, RESILIENCE, 
	MUSCLE_MEMORY, APTITUDE, CONSTITUTION, HEALTH_POINTS, STAMINA_POINTS, VIGOR_POINTS,
	AGILITY, CARRY_CAPACITY, RESISTANCE, FINESSE, HUNGER, THIRST, MASS, WEAPON_VALUE,ARMOR_VALUE,
	BUILD, WEIGHT, LIMB_HEALTH, INTERNAL_HEALTH, TOTAL_HEALTH, FATIGUE, STAMINA_BURN, STAMINA_REGEN }
enum ActivityLevel { SEDENTARY, LIGHT, MODERATE, HEAVY }
enum DamageType { KINETIC, EDGE_SLASH, EDGE_PIERCE, EDGE_CHOP }
enum BodyPart { 
	# Character Layer 1 (Outer)
	# Head Layer 1
	HEAD, FACE, NECK, BACK_OF_THE_HEAD, L_SIDE_OF_THE_HEAD, R_SIDE_OF_THE_HEAD, 
	L_EYE, R_EYE, L_EAR, R_EAR, NOSE,
	# Torso Layer 1
	TORSO, L_CHEST, R_CHEST, UPPER_BACK, LOWER_BACK, MID_BACK, LOWER_ABDOMEN,
	L_LOWER_ABDOMEN , R_LOWER_ABDOMEN, GROIN, L_ARMPIT, R_ARMPIT,
	# L_Arm Layer 1 + Hand
	L_ARM, L_HAND, L_SHOULDER, L_UPPER_ARM, L_LOWER_ARM, L_ELBOW, L_WRIST,
	# L Hand [For tracking ring equips and finer dex points]
	L_THUMB, L_INDEX_FINGER, L_MIDDLE_FINGER, L_RING_FINGER, L_LITTLE_FINGER,
	# R_Arm Layer 1 + Hand
	R_ARM, R_HAND, R_SHOULDER, R_UPPER_ARM, R_LOWER_ARM, R_ELBOW, R_WRIST,
	# R Hand [For tracking ring equips and finer dex points]
	R_THUMB, R_INDEX_FINGER, R_MIDDLE_FINGER, R_RING_FINGER, R_LITTLE_FINGER,
	# L_Leg Layer 1
	L_LEG, L_FOOT, L_UPPER_LEG, L_LOWER_LEG, L_KNEE, L_ANKLE,
	# L_Foot
	L_TOES,
	# R_Leg Layer 1
	R_LEG, R_FOOT, R_UPPER_LEG, R_LOWER_LEG, R_KNEE, R_ANKLE,
	# R_Foot
	R_TOES,
	# Generic Layer 1 [For targeting and damage calc, & UI selecetion] 
	BACK, SKIN, WRIST, EYES, EARS,
	# Character Layer 2 (Fat [For damage calc])
	# Generic Layer 2
	FAT,
	# Character Layer 3 (MUSCLE [For targeting and damage calc, & UI selecetion])
	# Head Layer 3
	CHEEKS, THROAT,
	# Torso Layer 3
	ABDOMINAL_MUSCLES, L_PEC, R_PEC, TRAPS, L_TRAP, R_TRAP, L_DELT, R_DELT,
	# L_Arm Layer 3 + Hand
	L_BICEP, L_TRICEP, L_FLEXORS,
	# R_Arm Layer 3 + Hand
	R_BICEP, R_TRICEP, R_FLEXORS,
	# L_Leg Layer 3
	L_HAMSTRING, L_QUADRICEP, L_SHIN, L_CALF, L_ACHILLES_TENDON,
	# R_Leg Layer 3
	R_QUADRICEP, R_HAMSTRING, R_SHIN, R_CALF, R_ACHILLES_TENDON,
	# Generic Layer 3 [For targeting and damage calc, & UI selecetion]
	MUSCLE, BICEPS, TRICEPS, FLEXORS, QUADRICEPS, HAMSTRINGS, SHINS, CALVES,
	# Character Layer 4 (BONE [For targeting and damage calc, & UI selecetion])
	# Head Layer 4
	SKULL, UPPER_JAW, LOWER_JAW, TEETH, L_ORBITAL, R_ORBITAL,
	# Torso Layer 4
	L_COLLARBONE, R_COLLARBONE, UPPER_SPINE, LOWER_SPINE, MID_SPINE,
	L_TRUE_RIBS, R_TRUE_RIBS, L_FALSE_RIBS, R_FALSE_RIBS, L_FLOATING_RIBS, R_FLOATING_RIBS,
	# L_Arm Layer 4 + Hand
	L_HUMERUS, L_RADIUS, L_ULNA, L_DIGITS,
	# R_Arm Layer 4 + Hand
	R_HUMERUS, R_RADIUS, R_ULNA, R_DIGITS,
	# L_Leg Layer 4
	L_HIP, L_FEMUR, L_TIBULA, L_FIBULA,
	# R_Leg Layer 4
	R_HIP, R_FEMUR, R_TIBULA, R_FIBULA,
	# Generic Layer 4 [For targeting and damage calc, & UI selecetion]
	SPINE, RIBS, JAW,
	# Character Layer 5 (ORGANS, ARTERIES, & VEINS [For targeting and damage calc, & UI selecetion])
	# Head Layer 5
	BRAIN, TOUNGE, LUNGS, STOMACH,
	 # Torso Layer 5
	HEART, L_PULMONARY_ARTERY, R_PULMONARY_ARTERY, L_PULMONARY_VEINS, R_PULMONARY_VEINS, L_KIDNEY, R_KIDNEY, LIVER,
	# L_Arm Layer 5 + Hand
	L_RADIAL_ARTERY, L_ULNAR_ARTERY, L_RADIAL_VEINS, L_ULNAR_VEINS,
	# R_Arm Layer 4 + Hand
	R_RADIAL_ARTERY,  R_ULNAR_ARTERY, R_RADIAL_VEINS,  R_ULNAR_VEINS,
	# L_Leg Layer 4    
	L_FEMORAL_ARTERY, L_TIBIAL_ARTERY,
	# R_Leg Layer 5
	R_FEMORAL_ARTERY, R_TIBIAL_ARTERY,
	# Generic Layer 4 [For targeting and damage calc, & UI selecetion]  
	KIDNEYS, INTERNALS, ATERIES, VEINS, PULMONARY_ARTERIES, PULMONARY_VEINS}
enum BuildFatClassification { ESSENTIAL, JACKED, ATHLETIC, AVERAGE, OBESE }
enum BuildMuscleClassification { JACKED, ATHLETIC, AVERAGE, OBESE }
enum BuildIndexValue {JACKED, BUFF, BRAWNY, HULKING, PAPER_SKINNED, SHREDDED, ATHLETIC, SOLID, STOCKY,
	GAUNT, RIPPED, TONED, AVERAGE, CHUBBY, STARVING, EMACIATED, THIN, UNDERTRAINED, OBESE, WASTING_AWAY,}
enum SkillKey {
	# Skills by Type
	COMBAT,
	#Combat Skill by Types & sub-Type
	STRIKING,
	PUNCHING, KICKING,
	 
	RANGED,
	SHORT_BOW, BOW, LONG_BOW, WAR_BOW, SLING, 
	CROSS_BOW, ARBALEST, HAND_CANNON, ARQUEBUS, RIFLE, PISTOL,
	
	ARTILLERY,
	CANNON, CATAPULT, TREBUCHET, ONAGER, MANGONEL, BALLISTA,
	
	GRAPPLING,
	THROWS, TAKEDOWNS, HOLDS,
	
	FOOTWORK,
	# Weapon Skills- [sub- category of Combat skills (ie. Striking)] 
	ONE_HANDED_FIGHTING, TWO_HANDED_FIGHTING, DUAL_WIELDING,
	BLUNT_WEAPON_FIGHTING, EDGE_WEAPON_FIGHTING,
	# Weapon Types [Sub catgory of weapon skill, levels weapon use efficency]
	POLEARM, JAVELIN, SPEAR, POLEAXE, SPEARSWORD, GLAIVE, PIKE,
	KNIFE, SHORT_KNIFE, LONG_KNIFE, 
	SWORD, SHORT_SWORD, LONG_SWORD, THRUSTING_SWORD, 
	SICKLE, AXE, 
	HAMMER, CLUB, STAFF, 
	SHIELD,   
	
	SURVIVAL, 
	CONDITIONING , MEDICAL, HUNTING, TRAPPING, GATHERING, SCAVENGING,
	
	AGRICULTURE, 
	ANIMAL_HUSBANDRY, AQUACULTURE, HORTICULTURE, FLORICULTURE, FORESTRY,
	 APICULTURE, FOOD_PROCESSING,
	
	STONEWORKING, 
	QUARRYING, SHAPING, CARVING, MASONRY,
	
	ROGUERY, 
	LOCKPICKING, STEALTH, DECEPTION, LARCENY,
	
	ATHLETICS, 
	RUNNING, JUMPING, THROWNING, WEIGHTLIFTING,
	
	METALLURGY, 
	PROCESSING, EXTRACTION, REFINING,
	
	LEARNING, 
	COOKING, CUISINE, 
	HISTORY, CULTURE, LANGUAGE, RELIGION, GEOGRAPHY, GEOLOGY,
	MERCANTILE, PERFORMANCE, 
	CULTIVATION, ARCANE, 
	HEAVY_ARMOR, LIGHT_ARMOR, MEDIUM_ARMOR,
	
	ARTISTRY, 
	WEAPON_SMITHING, ARMOR_SMITHING,
	GOLD_SMITHING, SILVER_SMITHING, JEWEL_CRAFTING,
	TANNERY, LEATHER_WORKING, WEAVING,
	POTTERY, GLASSMAKING,
	CARTOGRAPHY, CALLIGRAPHY,
	
	SPEECH,
	#Speech Skill types
	LOGOS, PATHOS , ETHOS,
	#Speech_Goal Skill Types
	BARTERING, COERCION, PERSUASION, ARGUMENTAION, COMMANDING, NEGOTIATION, 
	INTERROGATION, INQUIRY, 
	NARRATION, DESCRIPTION, EXPOSITION, 
	PRASISING, MOCKERY, 
	PLEADING,  
	
	CONTROL,
	CONTROL_FORCE, CONTROL_OUTPUT, CONTROL_USE
	}
enum SatiationLevel {STARVING, HUNGRY, PECKISH, MILD_FULLNESS, SATIATED, COMFORTABLY_FULL, STUFFED, BURSTING}
enum EdgeValue {BLUNT, DULL, SHARP}
# FAT PERCENTAGE RANGES (Stored as nested dictionaries for easy lookup)
# Format: { Classification : { Gender.MALE: [Min, Max], Gender.FEMALE: [Min, Max] } }
const FAT_PERCENT_RANGES: Dictionary = {
	BuildFatClassification.ESSENTIAL: {Gender.MALE: [2.0, 5.0], Gender.FEMALE: [10.0, 13.0]},
	BuildFatClassification.JACKED:    {Gender.MALE: [6.0, 13.0], Gender.FEMALE: [14.0, 20.0]},
	BuildFatClassification.ATHLETIC:  {Gender.MALE: [14.0, 17.0], Gender.FEMALE: [21.0, 24.0]},
	BuildFatClassification.AVERAGE:   {Gender.MALE: [18.0, 24.0], Gender.FEMALE: [25.0, 31.0]},
	BuildFatClassification.OBESE:     {Gender.MALE: [25.0, 100.0], Gender.FEMALE: [32.0, 100.0]}
}

# MUSCLE PERCENTAGE RANGES (SMM - Skeletal Muscle Mass)
const MUSCLE_PERCENT_RANGES: Dictionary = {
	BuildMuscleClassification.JACKED:    {Gender.MALE: [45.0, 100.0], Gender.FEMALE: [35.0, 100.0]},
	BuildMuscleClassification.ATHLETIC:  {Gender.MALE: [40.0, 44.0], Gender.FEMALE: [32.0, 34.0]},
	BuildMuscleClassification.AVERAGE:   {Gender.MALE: [36.0, 40.0], Gender.FEMALE: [28.0, 32.0]},
	BuildMuscleClassification.OBESE:     {Gender.MALE: [0.0, 36.0], Gender.FEMALE: [0.0, 28.0]}
}
# Classification of Build basedon Muscle and Fat content percentage
const BUILD_MATRIX_RANGES: Dictionary = {
	BuildIndexValue.JACKED: {Gender.MALE: [BuildMuscleClassification.JACKED, BuildFatClassification.JACKED], Gender.FEMALE: [BuildMuscleClassification.JACKED, BuildFatClassification.JACKED]},
	BuildIndexValue.ATHLETIC: {Gender.MALE: [BuildMuscleClassification.ATHLETIC, BuildFatClassification.ATHLETIC], Gender.FEMALE: [BuildMuscleClassification.ATHLETIC, BuildFatClassification.ATHLETIC]},
	BuildIndexValue.AVERAGE: {Gender.MALE: [BuildMuscleClassification.AVERAGE, BuildFatClassification.AVERAGE], Gender.FEMALE: [BuildMuscleClassification.AVERAGE, BuildFatClassification.AVERAGE]},
	BuildIndexValue.OBESE: {Gender.MALE: [BuildMuscleClassification.OBESE, BuildFatClassification.OBESE], Gender.FEMALE: [BuildMuscleClassification.OBESE, BuildFatClassification.OBESE]},
	BuildIndexValue.BUFF: {Gender.MALE: [BuildMuscleClassification.JACKED, BuildFatClassification.ATHLETIC], Gender.FEMALE: [BuildMuscleClassification.JACKED, BuildFatClassification.ATHLETIC]},
	BuildIndexValue.BRAWNY:  {Gender.MALE: [BuildMuscleClassification.JACKED, BuildFatClassification.AVERAGE], Gender.FEMALE: [BuildMuscleClassification.JACKED, BuildFatClassification.AVERAGE]},
	BuildIndexValue.HULKING:  {Gender.MALE: [BuildMuscleClassification.JACKED, BuildFatClassification.OBESE], Gender.FEMALE: [BuildMuscleClassification.JACKED, BuildFatClassification.OBESE]}, 
	BuildIndexValue.PAPER_SKINNED: {Gender.MALE: [BuildMuscleClassification.JACKED, BuildFatClassification.ESSENTIAL], Gender.FEMALE: [BuildMuscleClassification.JACKED, BuildFatClassification.ESSENTIAL]},  
	BuildIndexValue.SHREDDED:  {Gender.MALE: [BuildMuscleClassification.ATHLETIC, BuildFatClassification.JACKED], Gender.FEMALE: [BuildMuscleClassification.ATHLETIC, BuildFatClassification.JACKED]},  
	BuildIndexValue.SOLID: {Gender.MALE: [BuildMuscleClassification.ATHLETIC, BuildFatClassification.AVERAGE], Gender.FEMALE: [BuildMuscleClassification.ATHLETIC, BuildFatClassification.AVERAGE]},   
	BuildIndexValue.STOCKY: {Gender.MALE: [BuildMuscleClassification.ATHLETIC, BuildFatClassification.OBESE], Gender.FEMALE: [BuildMuscleClassification.ATHLETIC, BuildFatClassification.OBESE]}, 
	BuildIndexValue.GAUNT: {Gender.MALE: [BuildMuscleClassification.ATHLETIC, BuildFatClassification.ESSENTIAL], Gender.FEMALE: [BuildMuscleClassification.ATHLETIC, BuildFatClassification.ESSENTIAL]}, 
	BuildIndexValue.RIPPED: {Gender.MALE: [BuildMuscleClassification.AVERAGE, BuildFatClassification.JACKED], Gender.FEMALE: [BuildMuscleClassification.AVERAGE, BuildFatClassification.JACKED]},  
	BuildIndexValue.TONED: {Gender.MALE: [BuildMuscleClassification.AVERAGE, BuildFatClassification.ATHLETIC], Gender.FEMALE: [BuildMuscleClassification.AVERAGE, BuildFatClassification.ATHLETIC]},   
	BuildIndexValue.CHUBBY: {Gender.MALE: [BuildMuscleClassification.AVERAGE, BuildFatClassification.OBESE], Gender.FEMALE: [BuildMuscleClassification.AVERAGE, BuildFatClassification.OBESE]}, 
	BuildIndexValue.STARVING: {Gender.MALE: [BuildMuscleClassification.AVERAGE, BuildFatClassification.ESSENTIAL], Gender.FEMALE: [BuildMuscleClassification.AVERAGE, BuildFatClassification.ESSENTIAL]},  
	BuildIndexValue.EMACIATED: {Gender.MALE: [BuildMuscleClassification.OBESE, BuildFatClassification.JACKED], Gender.FEMALE: [BuildMuscleClassification.OBESE, BuildFatClassification.JACKED]},  
	BuildIndexValue.THIN: {Gender.MALE: [BuildMuscleClassification.OBESE, BuildFatClassification.ATHLETIC], Gender.FEMALE: [BuildMuscleClassification.OBESE, BuildFatClassification.ATHLETIC]},  
	BuildIndexValue.UNDERTRAINED: {Gender.MALE: [BuildMuscleClassification.OBESE, BuildFatClassification.AVERAGE], Gender.FEMALE: [BuildMuscleClassification.OBESE, BuildFatClassification.AVERAGE]},  
	BuildIndexValue.WASTING_AWAY: {Gender.MALE: [BuildMuscleClassification.OBESE, BuildFatClassification.ESSENTIAL], Gender.FEMALE: [BuildMuscleClassification.OBESE, BuildFatClassification.ESSENTIAL]},  
}

# --- COMBAT FORMULAS AND CONSTANTS ---
var Weapon_Sharpness = SHARPNESS_RATING

# Weapon Sharpness Ratings (Micrometers µm)

var SHARPNESS_RATING: Dictionary = {
	GameConstsRes.BLUNT: [1801, 2500], # 1.8-2.5 mm
	GameConstsRes.EdgeValue.DULL: [951, 1800], # 951 µm - 1.8 mm
	GameConstsRes.EdgeValue.SHARP: [950, 4.5], # 4.5 µm - 95 µm
	}
