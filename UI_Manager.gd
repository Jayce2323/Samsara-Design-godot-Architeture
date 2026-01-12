# UI_Manager.gd
extends CanvasLayer

# Change signal to pass a GameState value
signal state_requested(new_state: Main_Scene.GameState)

@onready var action_bar: Control = $ActionBar
@onready var inventory_ui: Control = $Inventory_UI

func _ready():
	if action_bar: action_bar.hide()
	if inventory_ui: inventory_ui.hide()

func _input(event):
	if event.is_action_pressed("Toggle_Hotbar"):
		get_viewport().set_input_as_handled()
		if inventory_ui and inventory_ui.visible:
			close_inventory()
		else:
			toggle_hotbar()

func toggle_hotbar():
	if action_bar == null: return
	
	if action_bar.visible:
		action_bar.hide()
		get_viewport().gui_release_focus()
		state_requested.emit(Main_Scene.GameState.WORLD)
	else:
		action_bar.show()
		state_requested.emit(Main_Scene.GameState.MENU)
		var first_tab = action_bar.get_node_or_null("HBoxContainer/InventoryButton")
		if first_tab: first_tab.grab_focus()

func open_inventory():
	if action_bar: action_bar.hide()
	if inventory_ui:
		inventory_ui.show()
		# Explicitly tell the Main_Scene we are in INVENTORY state
		state_requested.emit(Main_Scene.GameState.INVENTORY)
		# Now that it's shown, handle the focus
		inventory_ui.focus_first_slot()

func close_inventory():
	if inventory_ui: inventory_ui.hide()
	get_viewport().gui_release_focus()
	state_requested.emit(Main_Scene.GameState.WORLD)
