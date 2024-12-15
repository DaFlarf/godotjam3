extends Enemy_state

@export 
var idle_state: State
@export
var summon_state: State
@export
var sword_state: State
var movement: Vector2
var distance_to_player: float

func enter():
	find_direction()
	
func process_physics(delta: float) -> State:
	
	#check player speed
	var current_speed = abs(parent.velocity.length())
	if (parent.player != null):
		distance_to_player = (parent.player.position - parent.global_position).length()
		if distance_to_player > parent.MAX_RANGE:
			movement = target(parent.player.global_position)
		elif distance_to_player < parent.SWORD_RANGE:
			if (parent.can_attack):
				return sword_state
			else:
				var campy_dir: Vector2 = (parent.global_position - parent.player.position).normalized()
				movement = target(campy_dir)	
		else:
			if parent.can_attack:
				return summon_state
			movement = target(parent.global_position)
		
	else:
		movement = Vector2.ZERO
	if (movement == Vector2.ZERO):
		return idle_state
	
	parent.use_velocity(movement * move_speed)
	find_direction()
	parent.move_and_slide()
	
	return null
