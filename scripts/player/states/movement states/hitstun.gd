extends State

@export
var idle_state: State
@export 
var ded_state: State

var stun_timer: float

@onready
var ouch = $ouch

func enter():
	find_direction()
	stun_timer = parent.hitstun_to_take
	parent.health -= parent.damage_to_take
	if parent.health <= 0:
		return ded_state 
	else:
		ouch.play()

func process_physics(delta:float) -> State:
	stun_timer -= delta
	if(stun_timer <= 0):
		parent.damage_to_take = 0
		parent.direction_of_knockback = Vector2.ZERO
		parent.knockback_to_take = 0
		parent.hitstun_to_take = 0
		parent.stunned = false
		return idle_state
	parent.move_and_slide()
	return null
