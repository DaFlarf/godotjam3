extends Gun_state

@export 
var pacifism_state: Gun_state

@onready var MP7_cancel_timer = $MP7CancelTimer
@onready var MP7_finished_timer = $MP7FinishedTimer
@onready var sfx = $"HersheySquirts"

var cancellable: bool = false
var finished: bool = false

func enter():
	super()
	MP7_cancel_timer.start()
	parent.num_in_series += 1
	
func process_physics(delta: float) -> Gun_state:
	change_animation()
	
	if cancellable:
		if parent.using_primary:
			if parent.weapon_array.size() > 1 and parent.num_in_series < (parent.weapon_array.size()):
				return parent.weapon_array[parent.num_in_series]
	
	
	if finished:
		parent.num_in_series = 0
		return pacifism_state
		
	return null

func process_input(event: InputEvent) -> Gun_state:
	if move_component.wants_special():
		return pacifism_state
	return null

func _on_mp_7_cancel_timer_timeout() -> void:
	parent.spawn_MP7_boolet()
	sfx.play()
	cancellable = true
	MP7_finished_timer.start()

func _on_mp_7_finished_timer_timeout() -> void:
	finished = true
	parent.using_primary = false
	parent.using_offhand = false
	parent.num_in_series = 0

func exit():
	finished = false
	cancellable = false
