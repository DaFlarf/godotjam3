extends State

@export 
var walk_state: State

func process_physics(delta: float) -> State:
	
	#check player speed
	var current_speed = abs(parent.velocity.length())
	var movement = get_movement_input() 
	movement = movement.normalized()
	
	#if the player is touching the joystick
	if movement != Vector2(0,0):
		print(movement)
		return walk_state
		
	#slow the heck down
	if current_speed > 0: 
		current_speed -= 20
		parent.velocity = movement * current_speed
	return null
