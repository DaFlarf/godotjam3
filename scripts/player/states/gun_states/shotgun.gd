extends Gun_state

@export 
var pacifism_state: Gun_state

func enter():
	super()
	
func process_physics(delta: float) -> Gun_state:
	change_animation()
	return null

func process_input(event: InputEvent) -> Gun_state:
	if move_component.wants_special():
		return pacifism_state
	return null
