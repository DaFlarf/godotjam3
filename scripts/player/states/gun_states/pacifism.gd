extends Gun_state

func enter():
	super()
	
func process_physics(delta: float) -> Gun_state:
	change_animation()
	return null

func process_input(event: InputEvent) -> Gun_state:
	if move_component.wants_primary():
		return parent.weapon_array[0]
	if move_component.wants_offhand():
		if parent.offhand_weapon != null:
			return parent.offhand_weapon
		else:
			return parent.weapon_array[0]
	return null
