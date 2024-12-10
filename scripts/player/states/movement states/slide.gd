extends State

@export var idle_state: State
@export var dash_state: State
@export var brake_state: State

@export var slide_duration:= 0.5
var slide_timer
@export var traction:= 2.0

var movement: Vector2

func enter() -> void:
	find_direction()
	movement = get_movement_input() 
	movement = movement.normalized()
	slide_timer = slide_duration

func process_physics(delta: float) -> State:
	slide_timer -= delta
	if slide_timer <= 0.0:
		return idle_state
	if parent.slide_cancel == false:
		#check player speed
		var current_speed = abs(parent.velocity.length())
		#if you're walking
		if current_speed > 0:
				
			#slow the heck down
			current_speed -= traction
			parent.velocity = movement * current_speed
			
		elif current_speed <= 0:
			return idle_state
				
	else:
		#move without traction
		parent.move_and_slide()
	return null
	
func process_input(event: InputEvent) -> State:
	if(move_component.wants_dash()):
		parent.dash_cancel = true
		return dash_state
	if(move_component.wants_brake()):
		return brake_state
	return null

func exit() -> void:
		parent.slide_cancel = false
