#Base res for items

extends Resource

class_name Item_base

@export var item_name: String # e.g., "Iron Broadsword"
@export var Primaryitem_type: ItemEnums.ItemCategory
@export var ItemSecondary_type: ItemEnums.ItemSubCategory
@export var ItemCategory_type: ItemEnums.ItemTypeCategory
@export var ItemMiscCategory_type: Array [ItemEnums.ItemMiscCategory]
@export var ItemSize_type: ItemEnums.ItemSizeType
@export var material_type: Array [Material_Type] # Reference to a Material resource
@export var parts: Array [EnumsList.ItemTypeSubCategory]
@export var icon: Array [Texture2D]
@export var mass: float # Base mass of this specific shape (in kg)
