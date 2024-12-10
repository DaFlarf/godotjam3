extends State

@export 
var walk_state: State
@export 
var slide_state: State


func enter():
	find_direction()

func process_physics(delta: float) -> State:
	
	#check player speed
	var current_speed = abs(parent.velocity.length())
	var movement = get_movement_input() 
	movement = movement.normalized()
	
	#if the player is touching the joystick
	if movement != Vector2(0,0):
		return walk_state
		
	#slow the heck down
	if current_speed > 0: 
		current_speed -= 20
		parent.velocity = movement * current_speed
	return null

func process_input(event: InputEvent) -> State:
	if(move_component.wants_slide()):
		return slide_state
	return null
