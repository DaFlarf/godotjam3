extends Node

var movement_dir: Vector2

# Called when the node enters the scene tree for the first time.
func get_movement_direction():
	movement_dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	movement_dir.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	return movement_dir
