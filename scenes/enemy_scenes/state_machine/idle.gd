extends Enemy_state

@export 
var chase_state: State

func enter():
	find_direction()
	
func process_physics(delta: float) -> State:
	
	#check player speed
	var current_speed = abs(parent.velocity.length())
	var movement = target(parent.player.global_position)
	
	#if the player is touching the joystick
	if movement != Vector2(0,0):
		return chase_state
	
	return null
