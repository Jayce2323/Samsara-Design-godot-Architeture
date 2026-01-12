# ActionBar.gd
extends Control

@onready var tabs_container = $HBoxContainer

func _ready():
	if tabs_container == null:
		printerr("CRITICAL: ActionBar cannot find HBoxContainer node!")
		return
	
	var children = tabs_container.get_children()
	print("ActionBar found ", children.size(), " children in HBoxContainer.")

	for child in children:
		# BaseButton covers TextureButton, Button, etc.
		if child is BaseButton:
			# Pass the node's name to the pressed function
			child.pressed.connect(_on_tab_pressed.bind(child.name))
			child.focus_entered.connect(_on_tab_focused.bind(child))
			print("Signal connected for button: ", child.name)
		else:
			print("Skipping non-button node: ", child.name, " (Type: ", child.get_class(), ")")

func _on_tab_pressed(tab_name: String):
	print("Tab Pressed: ", tab_name)
	
	var main = get_tree().current_scene
	
	match tab_name:
		"InventoryButton": 
			# 1. Check if the Main Scene has a reference to the UI Manager
			if "ui_manager" in main and main.ui_manager != null:
				main.ui_manager.open_inventory()
			# 2. Fallback if the variable isn't found
			elif main.has_method("open_inventory"):
				main.open_inventory()
			else:
				printerr("Error: Could not find open_inventory on Main or UIManager.")
				
		"LookButton":
			if main.has_method("start_targeting_mode"):
				main.start_targeting_mode()

func _on_tab_focused(button: BaseButton):
	# Selection visual logic here if needed
	pass


func _on_inventory_button_pressed() -> void:
	pass # Replace with function body.
