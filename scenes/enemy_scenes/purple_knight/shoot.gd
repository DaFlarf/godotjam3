extends Enemy_state

@export
var idle_state: Enemy_state
@export 
var animation_time: float

var throw_timer: float

@onready
var pewpew = $"pew-pew"

func enter():
	face_player()
	throw_timer = animation_time
	parent.shoot_shotgun()
	pewpew.play()
	

func process_physics(delta: float) -> Enemy_state:
	if throw_timer > 0:
		throw_timer -= delta
		return null
	else:
		return idle_state
	
func exit():
	parent.attack_timer2.start()
	parent.can_shoot = false
