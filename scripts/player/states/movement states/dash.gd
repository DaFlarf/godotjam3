extends State

@export var move_state: State
@export var idle_state: State
@export var slide_state: State
@export var brake_state: State

@export var time_to_dash:= 0.09
@export var dash_duration:= 0.2
@export var dash_speed:= 1000

@onready var DashSFX = $DashSFX

var dash_timer = 0.0
var exit_dash_timer = 0.0
var movement: Vector2
var played_audio = false

func enter() -> void:
	find_direction()
	
	#start the timer
	if (parent.dash_cancel == false):
		dash_timer = time_to_dash
	else:
		dash_timer = 0
	exit_dash_timer = dash_duration
	movement = get_movement_input() 
	movement = movement.normalized()
	
func process_input(event: InputEvent) -> State:
	if (move_component.wants_slide()):
		parent.slide_cancel = true
		return slide_state
	if(move_component.wants_brake()):
		return brake_state
	return null

func process_physics(delta:float) -> State:
	dash_timer -= delta
	if dash_timer <= 0.0:
		play_audio()
		exit_dash_timer -= delta
		
		#if dash is over
		if exit_dash_timer <= 0.0:
			return move_state
		
		#if the player isn't touching anything, go to idle
		if movement == Vector2(0,0):
			return idle_state
		
		#dash
		if parent.velocity.length() <= dash_speed:	
			parent.velocity = movement * dash_speed
		else:
			parent.velocity = movement * parent.velocity.length()
		parent.move_and_slide()	
	return null

func play_audio():
	if played_audio == false:
		DashSFX.play()
		played_audio = true

func exit()-> void:
	parent.dash_cancel = false
	played_audio = false
