extends Node

class_name TimeManager

# You might use a signal to tell other scripts time has passed
signal day_passed

func _ready():
	# Example: run this every second of real time, or every 72000 turns in game time
	pass 

func process_new_day():
	# This is where you trigger the daily updates for all characters
	emit_signal("day_passed")
	# You would need a CharacterManager to handle the list of all characters
