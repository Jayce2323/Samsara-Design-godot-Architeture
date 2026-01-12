#Visual_Character

extends CharacterBody2D

class_name Visual_Character

@export var character_data: Character = null
@export var movement_duration: float = 0.2
var is_moving: bool = false
var target_position: Vector2 = Vector2.ZERO
var tile_size: Vector2 = Vector2(32, 16)

func _ready():
	# Initialize target to current position to prevent jumping on first move
	target_position = position
	
func connect_data(char_resource: Character) -> void:
	if char_resource == null:
		return
	self.character_data = char_resource
	print("Visual node linked to: ", character_data.character_name)

func _process(_delta: float) -> void:
	if character_data:
		if character_data.current_total_health <= 0 and is_inside_tree():
			queue_free()

func _unhandled_input(event):
	# STATE CHECK: Only move if the Main Scene is in WORLD mode
	var main = get_tree().current_scene
	if main.get("current_state") != Main_Scene.GameState.WORLD:
		return

	if is_moving:
		return

	var move_direction = Vector2.ZERO
	if event.is_action_pressed("ui_up"):
		move_direction = Vector2.UP
	elif event.is_action_pressed("ui_down"):
		move_direction = Vector2.DOWN
	elif event.is_action_pressed("ui_left"):
		move_direction = Vector2.LEFT
	elif event.is_action_pressed("ui_right"):
		move_direction = Vector2.RIGHT

	if move_direction != Vector2.ZERO:
		# Your original snap-to-tile movement
		target_position += move_direction * tile_size
		position = target_position 
		print("Moved to: ", position)

func update_visual_appearance() -> void:
	# Add your sprite/animation updates here based on character_data
	pass
