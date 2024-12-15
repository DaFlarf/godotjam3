extends Enemy_state

@export
var idle_state: State
@onready 
var hitbox_timer = $HitboxTimer
@onready
var lag_timer = $LagTimer

var finished = false

func enter():
	face_player()
	parent.invincible = true
	hitbox_timer.start()
	finished = false

func process_physics(delta: float) -> Enemy_state:
	if finished:
		return idle_state
	return null


func _on_hitbox_timer_timeout() -> void:
	parent.swing_sword()
	lag_timer.start()


func _on_lag_timer_timeout() -> void:
	finished = true

func exit():
	parent.invincible = false
