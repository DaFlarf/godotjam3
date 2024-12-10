extends State
@export var idle_state: State

func enter() -> void:
	find_direction()
	
func process_physics(delta: float) -> State:
	parent.velocity = Vector2(0,0)
	return idle_state
