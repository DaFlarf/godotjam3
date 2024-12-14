class_name Enemy_state
extends State

func target(pos: Vector2) -> Vector2:
	return parent.target(pos)

func use_velocity(new_velocity: Vector2) -> void:
	parent.use_velocity()

func face_player() -> void:
	var movement_dir = parent.global_position.direction_to(parent.player.global_position)
	if movement_dir.x < 0: dir = "_left"
	elif movement_dir.x > 0: dir = "_right"
	elif movement_dir.y < 0: dir = "_up"
	elif movement_dir.y > 0: dir = "_down"
	else:
		dir = parent.dir
	update_animation()
	parent.dir = dir
