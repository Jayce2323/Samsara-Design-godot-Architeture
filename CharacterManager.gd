#CharacterManager

extends Node

class_name CharacterManager

var all_characters: Array[Character] = []
const VISUAL_CHARACTER_SCENE: PackedScene = preload("res://Scenes/Character_scn/Visual_character.tscn")
var visual_nodes: Dictionary = {} 

func spawn_character_visual(char_data: Character, spawn_position: Vector2) -> Visual_Character:
	if visual_nodes.has(char_data):
		return visual_nodes[char_data]

	var visual_instance: Visual_Character = VISUAL_CHARACTER_SCENE.instantiate()
	# Add to the root scene so it is not a child of this manager
	get_tree().current_scene.add_child(visual_instance)
	
	visual_instance.global_position = spawn_position
	visual_instance.connect_data(char_data)
	
	visual_nodes[char_data] = visual_instance
	# RETURN the instance so player_node in Main Scene isn't null
	return visual_instance

func on_day_passed():
	for char_data in all_characters:
		var daily_avg_stomach_fill = 1000.0 
		BioFormulaHub.process_daily_cycle(char_data, daily_avg_stomach_fill)
		if char_data.current_total_health <= 0:
			die("Zero Health", char_data)
			continue 
		char_data.mark_dirty()

func remove_character(char_data: Character):
	all_characters.erase(char_data)
	if visual_nodes.has(char_data):
		var visual_instance = visual_nodes[char_data]
		if is_instance_valid(visual_instance):
			visual_instance.queue_free()
		visual_nodes.erase(char_data)

func die(reason: String, character_instance: Character):
	print(character_instance.character_name, " has died due to: ", reason)
	remove_character(character_instance)
