extends State

@export var idle_state: State
@export var dash_state: State
@export var brake_state: State

@export var slide_duration:= 0.5
var slide_timer
@export var traction:= 2.0

var movement: Vector2

@onready var SlideSFX = $SlideSFX

func enter() -> void:
	find_direction()
	movement = get_movement_input() 
	movement = movement.normalized()
	slide_timer = slide_duration
	parent.velocity = movement * (parent.velocity.length() + 10)
	parent.disable_hurtbox()
	SlideSFX.play()

func process_physics(delta: float) -> State:
	slide_timer -= delta
	if slide_timer <= 0.0:
		return idle_state
	
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
		parent.enable_hurtbox()
