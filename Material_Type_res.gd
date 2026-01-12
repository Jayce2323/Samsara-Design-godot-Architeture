#Material_Type

extends Resource

class_name Material_Type

@export var material_name: String
# Dictionary of chemical symbols and percentages/proportions (e.g., {"Cu": 0.88, "Sn": 0.12})
@export var elemental_composition: Dictionary
@export var description: String
@export var base_Hardness: float
#@export var specific_heat:
