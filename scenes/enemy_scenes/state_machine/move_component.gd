extends Node

@onready var parent = $".."

func get_movement_direction() -> Vector2:
	return parent.velocity
