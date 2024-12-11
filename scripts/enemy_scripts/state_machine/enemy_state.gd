class_name Enemy_state
extends State

func target(pos: Vector2) -> Vector2:
	return parent.target(pos)

func use_velocity(new_velocity: Vector2) -> void:
	parent.use_velocity()
