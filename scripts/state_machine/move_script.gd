extends Node

var movement_dir: Vector2

# Called when the node enters the scene tree for the first time.
func get_movement_direction() -> Vector2:
	#movement_dir = Input.get_vector("left", "right", "up", "down")
	movement_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	movement_dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	return movement_dir

func wants_dash() -> bool:
	if (Input.is_action_just_pressed("dash")):
		return true
	return false

func wants_slide() -> bool:
	if (Input.is_action_just_pressed("slide")):
		return true
	return false

func wants_brake() -> bool:
	if (Input.is_action_just_pressed("brake")):
		return true
	return false
