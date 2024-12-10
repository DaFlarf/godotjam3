extends State
@export 
var idle_state: State
@export
var dash_state: State
@export
var brake_state: State
@export
var slide_state: State

#update facing
func enter() -> void:
	find_direction()

func process_physics(delta: float) -> State:
	
	#check player speed
	var current_speed = abs(parent.velocity.length())
	var movement = get_movement_input() 
	movement = movement.normalized()
	
	#if you aren't super fast
	if current_speed <= move_speed:
		
		#if you're not moving
		if movement == Vector2(0,0):
			return idle_state
			
		else:
			find_direction()
		
		#move those legs
		parent.velocity = movement * move_speed
		
	else: #slow the heck down
		current_speed -= 20
		parent.velocity = movement * current_speed
	parent.move_and_slide()	
	return null
	
func process_input(event: InputEvent) -> State:
	if(move_component.wants_dash()):
		return dash_state
	if(move_component.wants_brake()):
		return brake_state
	if(move_component.wants_slide()):
		return slide_state
	return null
