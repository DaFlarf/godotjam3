extends Gun_state

func enter():
	super()
	
func process_physics(delta: float) -> Gun_state:
	change_animation()
	return null

func process_input(event: InputEvent) -> Gun_state:
	if parent.state_machine.current_state != parent.state_machine.hitstun_state:
		if move_component.wants_primary():
			parent.using_primary = true
			parent.num_in_series = 0
			return parent.weapon_array[0]
		if move_component.wants_offhand():
			if parent.offhand_weapon != null:
				parent.using_offhand = true
				return parent.offhand_weapon
			else:
				parent.using_primary = true
				parent.num_in_series = 0
				return parent.weapon_array[0]
	return null
