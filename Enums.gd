#extends Node

#class_name ItemEnums

# Defines Item Category
enum ItemType {
	EQUIPPABLE,
	CONSUMABLE, 
	MATERIALS,
	CONTAINERS,
	FUNCTIONAL,
	QUEST_ITEM,
	ARTIFACT,
	CURRENCY,
	FURNITURE,
	KEYS,
	MISC,
	}

# Defines Item Sub-Category
enum EquippableType { 
	ARMOR, 
	WEAPONS, 
	JEWELRY, 
	CLOTHING,
	}
enum ConsumableType { 
	FOOD, 
	DRINK, 
	MEDICINE, 
	POTION, 
	POISON, 
	AMMUNITION,
	}
enum MaterialsType { 
	MINERAL, 
	LUMBER, 
	TEXTILE, 
	ANIMALSKIN, 
	WEAPONPART, 
	POTTERY,
	}
enum ContainersType { 
	BAG, 
	BOX, 
	VASE, 
	JAR, 
	CUP, 
	CHEST, 
	POUCH, 
	POT, 
	BARREL,
	PLATE,
	BOWL,
	}
enum FunctionalType { 
	TOOLS, 
	DEVICES, 
	SEALS, 
	TOMES, 
	BOOKS, 
	SCROLL, 
	NOTE, 
	MAP, 
	}
enum FurnitureType {}

# Defines Item Class (seperated by sub-category)
#EquippableType
enum ArmorType { 
	HEAD, 
	HAND, 
	TORSO, 
	ARM, 
	LEG, 
	FOOT
	}
enum WeaponsType { 
	KNIFE, 
	AXE, 
	HAMMER, 
	MACE, 
	WARCLUB, 
	POLEARM, 
	STAFF, 
	SHIELD, 
	BOW, 
	FIREARM,
	SLING 
	}
enum JewelryType { 
	NECKLACE, 
	RING, 
	EARRING, 
	BROOCH, 
	ANKLET, 
	BRACELET, 
	PIERCING, 
	ADORNMENT
	}
enum ClothingType { 
	HEADGARMENT, 
	HANDGARMENT, 
	TORSOGARMENT, 
	ARMGARMENT, 
	LEGGARMENT, 
	FOOTWEAR,
	}
#ConsumableType
enum FoodType { 
	VEGETABLE, 
	MEAT, 
	MUSHROOM, 
	HERBS, 
	SPICES
	}
enum DrinkType { 
	WATER, 
	ALCOHOL, 
	TEA, 
	COFFEE, 
	JUICE
	}
enum MedicineType { 
	LIQUID, 
	SOLID, 
	EMULSION, 
	}
enum PotionType { 
	RESTORATIVE, 
	ENHANCEMENT, 
	WILLBENDING,
	 }
enum DrugType { 
	STIMULANT, 
	DEPRESSANT, 
	HALLUCINOGEN, 
	FACILITATOR, 
	BLOCKER, 
	PAINRELIEVER, 
	ANTIBIOTIC,
	ANTIFUNGAL,
	ANTIMICROBIAL,
	DIURETIC,
	}
enum PoisonType { 
	CORROSIVE, 
	IRRITANT, 
	SYSTEMIC, 
	ASPHIXIANT, 
	GENERAL
	}
enum AmmunitionType {}
#MaterialsType
enum MineralType { 
	ROCK,
	CLAY, 
	INGOT, 
	SLAG, 
	GEM
	}  
enum LumberType {
	LOG, 
	TRUNK, 
	BOUGH,
	BRANCH, 
	TWIG
	}
enum TextileType {
	NETTLE, 
	FLAX, 
	JUTE, 
	COTTON, 
	HEMP, 
	SILK,
	}  
enum AnimalskinType {
	FUR,  
	PELT, 
	HIDE
	}
enum WeaponpartType { 
	HILT, 
	BLADE, 
	AXEHEAD, 
	BLUNTHEAD, 
	HELVE, 
	HAFT
	}
enum PotteryType {
	EARTHENWARE, 
	STONEWARE, 
	PORCELAIN,
	}

# Defines Misc Item Stats
enum ArmorConstrutionType {
	Textile,
	Linked,
	Plate,
	}
enum ArmorThicknessType{
	Light,
	Medium,
	Heavy,
	}
enum EquipSideType { 
	LEFT,
	RIGHT,
	}
enum ItemSizeType {
	SMALL, 
	LARGE, 
	GIANT, 
	TINY, 
	NORMAL
	}
enum FoodPrimaryFlavorType { 
	SWEET, 
	SOUR, 
	SALTY, 
	BITTER, 
	UMAMI
	}
enum FoodSecondaryFlavorType { 
	SPICY, 
	MINT, 
	MELON, 
	FRUITY, 
	CITRUS, 
	BERRY, 
	EARTHY, 
	BRINY, 
	FISHY, 
	SMOKEY, 
	TART, 
	PEPPERY, 
	PUNGENT, 
	LICORICE, 
	NUTTY, 
	GAMEY, 
	WOODY, 
	HERBAL, 
	FLORAL, 
	STARCHY, 
	FATTY, 
	ACIDIC
	}
enum FoodTextureType { 
	TENDER, 
	CHEWY, 
	MOIST, 
	CRISP, 
	DELICATE, 
	SOFT, 
	FIRM, 
	JUICY, 
	WATERY, 
	CREAMY, 
	MUSHY, 
	TOUGH, 
	FIBOROUS, 
	WAXY, 
	DRY, 
	SPONGEY, 
	CRUNCHY
	}
enum FlavorIntensity { 
	BLAND, 
	WEAK, 
	MILD, 
	MIDDLING, 
	STRONG, 
	RICH, 
	FULL, 
	SHARP
	}
