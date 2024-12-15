extends Enemy_state

@export
var idle_state: Enemy_state
@export 
var animation_time: float

var throw_timer: float

@onready
var pewpew = $"pew-pew"

func enter():
	parent.invincible = true
	face_player()
	throw_timer = animation_time
	parent._throw_knife()
	pewpew.play()
	

func process_physics(delta: float) -> Enemy_state:
	if throw_timer > 0:
		throw_timer -= delta
		return null
	else:
		return idle_state
	
func exit():
	parent.attack_timer.start()
	parent.invincible = false
	parent.can_attack = false
