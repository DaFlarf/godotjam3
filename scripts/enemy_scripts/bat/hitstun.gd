extends Enemy_state

@export
var idle_state: Enemy_state
@export 
var ded_state: Enemy_state

var stun_timer: float

func enter():
	find_direction()
	stun_timer = parent.hitstun_to_take
	parent.health -= parent.damage_to_take

func process_physics(delta:float) -> Enemy_state:
	if parent.health <= 0:
		return ded_state
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

func exit() -> void:
	pass
