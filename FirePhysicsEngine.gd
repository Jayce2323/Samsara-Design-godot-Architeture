extends Node

class_name FirePhysicsEngine
# PDF 3 Formulas
static func apply_energy_to_material(joules: float, material: Material_Type, mass_kg: float) -> Dictionary:
	# 1. Calculate Temperature Change
	# Q = mcΔT -> ΔT = Q / (m * c)
	# c = specific_heat from your JSON data (e.g., Iron = 449)
	var specific_heat = material.specific_heat 
	var temp_change = joules / (mass_kg * specific_heat)
	
	# 2. Return State Changes
	return {
		"temp_delta": temp_change,
		"new_state_phase": _check_phase_change(material, temp_change) 
		# You would check melting point here from your Periodic Dictionary
	}

static func _check_phase_change(material: Material_Type, current_temp: float) -> int:
	# Check fusion_heat / melting points from your dictionary
	# "fusion_heat": 13.8 for Iron (from PDF 10)
	return 0 # Return Enum for Solid/Liquid/Gas
