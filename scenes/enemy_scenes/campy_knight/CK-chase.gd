extends Enemy_state

@export 
var idle_state: State
var movement: Vector2
var distance_to_player: float

func enter():
	face_player()
	
func process_physics(delta: float) -> State:
	
	#check player speed
	var current_speed = abs(parent.velocity.length())
	if (parent.player != null):
		distance_to_player = (parent.player.position - parent.global_position).length()
		if distance_to_player > parent.MAX_DISTANCE_TO_PLAYER:
			movement = target(parent.player.global_position)
		elif distance_to_player < parent.MIN_DISTANCE_TO_PLAYER:
			var campy_dir: Vector2 = (parent.global_position - parent.player.position).normalized()
			movement = target(campy_dir)
		else:
			movement = target(parent.global_position)	
		
	else:
		movement = Vector2.ZERO
	if (movement == Vector2.ZERO):
		return idle_state
	
	parent.use_velocity(movement * move_speed)
	find_direction()
	parent.move_and_slide()
	
	return null
