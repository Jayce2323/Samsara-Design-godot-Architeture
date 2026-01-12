extends Resource
class_name Inventory

signal inventory_updated # Emitted when data changes
# Stores ItemData resources
@export var items: Array[Item_base] = []
@export var capacity: int = 20

# Function to add an item
func add_item(item: Item_base):
	items.append(item.duplicate_deep()) # Use 4.5 deep duplication
	inventory_updated.emit() # Notify the UI

func remove_item_at(index: int):
	if index >= 0 and index < items.size():
		items.remove_at(index)
		inventory_updated.emit()
