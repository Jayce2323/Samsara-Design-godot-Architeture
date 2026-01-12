extends Node
#Combat Operands
class_name CombatHub

const WEAR_COEFFICIENT_K: float = 1.0
const FRACTURE_COEFFICIENT_KF: float = 0.1 # Updated from 0.001 to 0.1 as per notes

# Force Multipliers based on attack type
const MULTIPLIER_CHOP: float = 1.5
const MULTIPLIER_PIERCE: float = 2.0

# Function to calculate Armor Defense Value (ADV) - used in DmgChck/PenChck
static func calculate_armor_defense_value(base_av: float, material_hardness: float, mass: float) -> float:
# ADV = (Base AV)*(MaterialHardness+Mass)
 return base_av * (material_hardness + mass)

# Function to calculate Weapon Ductility Value (WDV)
static func calculate_weapon_ductility_value(hardness: float) -> float:
	# WDV = [(1/Hardness)]x C(Scaling factor = 1)
	# Assumes C=1 as per notes
  if hardness > 0:
   return 1.0 / hardness
  return 0.0

# Function to calculate Kinetic Damage (KD)
static func calculate_kinetic_damage(mass_of_parts: float, material_hardness_by_part: float) -> float:
	# KD = (Mass (of parts))*(Material Hardness (by part))
 return mass_of_parts * material_hardness_by_part

# Function to calculate Edge Damage (ED)
static func calculate_edge_damage(material_hardness: float, edge_radius_micrometers: float) -> float:
	# ED = (Hardness*100)/Edge radius (µm). Returns 0 if blunt (radius > 1000µm from notes)
 if edge_radius_micrometers > 2000.0: return 0.0
 if edge_radius_micrometers > 0:
  return (material_hardness * 100.0) / edge_radius_micrometers
 return 0.0

# Function to calculate Penetration Check Score (Sharp Weapon)
static func calculate_penetration_check_score(attacker_edge_damage_value: float, attacker_power: float, armor_hardness: float) -> float:
	# PenChck = ADV (ED) - (ED*(Power-Armor Hardness)) -- Requires interpretation of notes
	# This formula needs careful implementation in the Combat Manager script to match the intended game logic loop exactly
 return attacker_edge_damage_value - (attacker_edge_damage_value * (attacker_power - armor_hardness))

# Function to calculate Edge Retention Value (ERV) Loss (happens after PenChck/DmgChck)
static func calculate_erv_loss(blade_hardness: float, force: float, item_hardness: float) -> float:
	# ERV Loss = [K=1] x [(Hblade[blade_hardness] / [(Frc[Force] x Hitem[item hardness])]
  if force * item_hardness > 0:
   return WEAR_COEFFICIENT_K * (blade_hardness / (force * item_hardness))
  return 0.0

# Function to calculate Fracture Risk Value (FRV) (happens after PenChck/DmgChck)
static func calculate_frv(force: float, item_hardness: float, weapon_ductility_value: float) -> float:
	# FRV = [Kf=0.1] x [[(Frc[Force] x Hitem[item hardness]] / [Dweapon (WDV)]
  if weapon_ductility_value > 0:
   return FRACTURE_COEFFICIENT_KF * ((force * item_hardness) / weapon_ductility_value)
  return 0.0


# Function to calculate Damage Check Score (Edge/Pierce Weapons)
static func calculate_damage_check_edge(armor_defense_value_edge: float, edge_damage: float, power: float, armor_hardness_total: float) -> float:
	# DmgChck= ADV (EdgeDefense) - (EdgeDamage*(Power-(Armor Hardness (Total))))
 return armor_defense_value_edge - (edge_damage * (power - armor_hardness_total))

# Function to calculate Damage Check Score (Blunt/Kinetic Weapons)
static func calculate_damage_check_kinetic(armor_defense_value_kinetic_total: float, kinetic_damage: float, power: float, armor_hardness_layer1: float) -> float:
	# DmgChck = (ADV(L1)(KD) + ADV(L2)(KD)) - (Kinetic Damage*(Power-Armor Hardness(L1)))
	# This requires the specific total ADV and just the first layer hardness
 return armor_defense_value_kinetic_total - (kinetic_damage * (power - armor_hardness_layer1))
