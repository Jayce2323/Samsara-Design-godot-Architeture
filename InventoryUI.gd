# InventoryUI.gd
extends Control

@onready var grid: GridContainer = %GridContainer
@onready var slot_scene = preload("res://Scenes/UI/Inventory_Slot.tscn")
var current_inventory: Inventory

func set_inventory(inv: Inventory):
	current_inventory = inv
	if not current_inventory.inventory_updated.is_connected(refresh_ui):
		current_inventory.inventory_updated.connect(refresh_ui)
	refresh_ui()

func refresh_ui():
	if grid == null: return
	
	# Clear existing slots
	for child in grid.get_children():
		child.queue_free()
	
	# Rebuild slots from data
	if current_inventory:
		for item in current_inventory.items:
			var slot = slot_scene.instantiate()
			grid.add_child(slot)
			if slot.has_method("set_item"):
				slot.set_item(item)

# Call this from UIManager after calling .show()
func focus_first_slot():
	# Wait for the end of the frame so visibility is fully updated
	await get_tree().process_frame
	if grid.get_child_count() > 0:
		var first_slot = grid.get_child(0)
		if first_slot.is_visible_in_tree():
			first_slot.grab_focus()
