extends Enemy_state

@export 
var idle_state: State
var movement: Vector2

func enter():
	find_direction()
	
func process_physics(delta: float) -> State:
	
	#check player speed
	var current_speed = abs(parent.velocity.length())
	if (parent.player != null):
		movement = target(parent.player.global_position)
	else:
		movement = Vector2.ZERO
	if (movement == Vector2.ZERO):
		return idle_state
	
	parent.use_velocity(movement * move_speed)
	parent.move_and_slide()
	
	return null
