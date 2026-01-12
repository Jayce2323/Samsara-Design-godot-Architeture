# Main_Scene.gd

extends Node2D

class_name Main_Scene

enum GameState { WORLD, MENU, INVENTORY, WORLD_MAP }
var current_state: GameState = GameState.WORLD

@onready var ui_manager: CanvasLayer = $UIManager
@onready var character_manager: CharacterManager = %CharacterManager
@onready var time_manager: TimeManager = $TimeManager
@onready var inventory_ui: Control = %Inventory_UI

# The variable that was missing from scope:
var player_node: Visual_Character = null
var player_inventory: Inventory = Inventory.new()

func _ready():
	await get_tree().process_frame 
	
	if character_manager == null:
		printerr("CRITICAL ERROR: %CharacterManager not found.")
		return

	# 1. Initialize Character Data
	var test_char = Character.new()
	test_char.character_name = "Test Subject A"
	test_char.initialize_starting_state()
	
	# 2. Setup Inventory Data BEFORE Spawning
	player_inventory = Inventory.new()
	add_test_items(player_inventory)
	test_char.inventory = player_inventory # Link data to character
	
	# 3. Spawn Visual and store in player_node
	character_manager.all_characters.append(test_char)
	player_node = character_manager.spawn_character_visual(test_char, Vector2(100, 100))

	# 4. Link populated data to UI
	if inventory_ui:
		inventory_ui.set_inventory(player_inventory)
		 
	if ui_manager:
		ui_manager.state_requested.connect(_on_state_requested)

func add_test_items(inv: Inventory):
	var sword_res = load("res://Resources/Equipment_Res/Test_Sword_Item.tres") 
	if sword_res:
		inv.items.append(sword_res)
		print("Added sword to inventory.")
	else:
		printerr("Failed to load Test_Sword_Item.tres! Check path.")

func _on_state_requested(new_state: GameState):
	current_state = new_state
	print("Game State changed to: ", GameState.keys()[current_state])

func _on_menu_toggled(is_open: bool):
	if is_open:
		print("Game Paused: UI Open")
	else:
		print("Game Resumed: UI Closed")
