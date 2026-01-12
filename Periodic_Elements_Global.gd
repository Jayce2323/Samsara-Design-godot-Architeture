# PeriodicElements

extends Node

var chemical_elements = {
	"H": {"name": "HYDROGEN", "density": 0.0898, "atomic_mass": 1.01, "specific_heat": 14300, "fusion_heat": 0.558, "vapor_heat": 0.452},
	"C": {"name": "CARBON", "density": 2.26, "atomic_mass": 12.01, "specific_heat": 710, "fusion_heat": 105, "vapor_heat": 715},
	"N": {"name": "NITROGEN", "density": 0.0012, "atomic_mass": 14.01, "specific_heat": 1040, "fusion_heat": 0.36, "vapor_heat": 2.79},
	"B":  {"name": "BORON", "density": 2.35, "atomic_mass": 10.8, "specific_heat": 1030, "fusion_heat": 50.2, "vapor_heat": 508},
	"O": {"name": "OXYGEN", "density": 0.00143, "atomic_mass": 16, "specific_heat": 919, "fusion_heat": 0.222, "vapor_heat": 3.41},
	"NA": {"name": "SODIUM", "density": 0.968, "atomic_mass": 3, "specific_heat": 1230, "fusion_heat": 2.6, "vapor_heat": 97.7},
	"BE": {"name": "BERYLLIUM", "density": 1.85, "atomic_mass": 9.012, "specific_heat": 1820, "fusion_heat": 7.95, "vapor_heat": 297},
	"MG": {"name": "MAGNESIUM", "density": 1.738, "atomic_mass": 24, "specific_heat": 1020, "fusion_heat": 8.7, "vapor_heat": 128},
	"AL": {"name": "ALUMINUM", "density": 2.7, "atomic_mass": 27, "specific_heat": 904, "fusion_heat": 10.7, "vapor_heat": 293},
	"SI": {"name": "SILICON", "density": 2.65, "atomic_mass": 28.1, "specific_heat": 710, "fusion_heat": 50.2, "vapor_heat": 359},
	"S": {"name": "SULFUR", "density": 1.96, "atomic_mass": 32.06, "specific_heat": 705, "fusion_heat": 1.73, "vapor_heat": 9.8},
	"CL": {"name": "SULFUR", "density": 0.0032, "atomic_mass": 35.45, "specific_heat": 478.2, "fusion_heat": 3.2, "vapor_heat": 10.2},
	"K": {"name": "POTASSIUM", "density": 0.89, "atomic_mass": 39.1, "specific_heat": 757, "fusion_heat": 2.33, "vapor_heat": 76.9},
	"CA": {"name": "CALCIUM", "density": 1.55, "atomic_mass": 40.08, "specific_heat": 631, "fusion_heat": 8.54, "vapor_heat": 155},
	"TI": {"name": "TITANIUM", "density": 45.06, "atomic_mass": 47.9, "specific_heat": 520, "fusion_heat": 18.7, "vapor_heat": 425},
	"FG": {"name": "FOOLSGOLD", "density": 45.06, "atomic_mass": 47.9, "specific_heat": 520, "fusion_heat": 18.7, "vapor_heat": 425},
	"V": {"name": "VANADIUM", "density": 6.11, "atomic_mass": 50.94, "specific_heat": 489, "fusion_heat": 22.8, "vapor_heat": 453},
	"RN": {"name": "REDNOVA", "density": 6.11, "atomic_mass": 50.94, "specific_heat": 489, "fusion_heat": 22.8, "vapor_heat": 453},
	"CR": {"name": "CHROMIUM", "density": 7.15, "atomic_mass": 52, "specific_heat": 448, "fusion_heat": 20.5, "vapor_heat": 339},
	"CG": {"name": "CERULIUMGLASS", "density": 7.15, "atomic_mass": 52, "specific_heat": 448, "fusion_heat": 20.5, "vapor_heat": 339},
	"MN": {"name": "MANGANESE", "density": 7.21, "atomic_mass": 4.94, "specific_heat": 479, "fusion_heat": 13.2, "vapor_heat": 220},
	"FE": {"name": "IRON", "density": 7.4, "atomic_mass": 55.85, "specific_heat": 449, "fusion_heat": 13.8, "vapor_heat": 347},
	"CO": {"name": "COBALT", "density": 8.9, "atomic_mass": 58.93, "specific_heat": 421, "fusion_heat": 16.2, "vapor_heat": 375},
	"NI": {"name": "NICKEL", "density": 8.9, "atomic_mass": 58.7, "specific_heat": 445, "fusion_heat": 17.2 , "vapor_heat": 378},
	"CU": {"name": "COPPER", "density": 8.96, "atomic_mass": 63.55, "specific_heat": 384.4, "fusion_heat": 13.1, "vapor_heat": 300},
	"ZN": {"name": "ZINC", "density": 7.14, "atomic_mass": 65.38, "specific_heat": 388, "fusion_heat": 7.35, "vapor_heat": 119},
	"AS": {"name": "ARSENIC", "density": 5.727, "atomic_mass": 74.92, "specific_heat": 328, "fusion_heat": 27.7, "vapor_heat": 32.4},
	"AG": {"name": "SILVER", "density": 10.49, "atomic_mass": 107.87, "specific_heat": 235, "fusion_heat": 11.3, "vapor_heat": 255},
	"SN": {"name": "TIN", "density": 7.265, "atomic_mass": 118.69, "specific_heat": 217, "fusion_heat": 7, "vapor_heat": 290},
	"SB": {"name": "ANTIMONY", "density": 11.34, "atomic_mass": 121.75, "specific_heat": 207, "fusion_heat": 19.7, "vapor_heat": 67},
	"W": {"name": "TUNGSTEN", "density": 45.06, "atomic_mass": 47.9, "specific_heat": 132, "fusion_heat": 35, "vapor_heat": 800},
	"BM": {"name": "BLACKMETAL", "density": 45.06, "atomic_mass": 47.9, "specific_heat": 132, "fusion_heat": 35, "vapor_heat": 800},
	"PT": {"name": "PLATINUM", "density": 21.45, "atomic_mass": 195.09, "specific_heat": 133, "fusion_heat": 20, "vapor_heat": 490},
	"E": {"name": "EIS", "density": 21.45, "atomic_mass": 195.09, "specific_heat": 133, "fusion_heat": 20, "vapor_heat": 490},
	"AU": {"name": "GOLD", "density": 6.697, "atomic_mass": 196.97, "specific_heat": 129.1, "fusion_heat": 12.5, "vapor_heat": 330},
	"HG": {"name": "MERCURY", "density": 13.534, "atomic_mass": 200.59, "specific_heat": 139.5, "fusion_heat": 2.29, "vapor_heat": 59.2},
	"PB": {"name": "LEAD", "density": 11.34, "atomic_mass": 207.2, "specific_heat": 127, "fusion_heat": 4.77, "vapor_heat": 178},
	# ... more elements
}

func get_element_density(symbol: String):
	if chemical_elements.has(symbol):
		return chemical_elements[symbol]["density"]
	return 0.0
