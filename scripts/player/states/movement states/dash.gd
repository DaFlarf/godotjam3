extends State

@export var move_state: State
@export var idle_state: State
@export var slide_state: State

@export var time_to_dash:= 0.09
@export var dash_duration:= 0.2
@export var dash_speed:= 1000
var dash_timer = 0.0
var exit_dash_timer = 0.0
var movement: Vector2

func enter() -> void:
	super()
	
	#start the timer
	dash_timer = time_to_dash
	exit_dash_timer = dash_duration
	movement = get_movement_input() 
	movement = movement.normalized()
	
func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta:float) -> State:
	dash_timer -= delta
	if dash_timer <= 0.0:
		exit_dash_timer -= delta
		
		#if dash is over
		if exit_dash_timer <= 0.0:
			return move_state
		
		#if the player isn't touching anything, go to idle
		if movement == Vector2(0,0):
			return idle_state
		
		#dash	
		parent.velocity = movement * dash_speed
		parent.move_and_slide()	
		
	return null
  
func process_Input(event: InputEvent):
	if move_component.wants_slide():
		return slide_state
