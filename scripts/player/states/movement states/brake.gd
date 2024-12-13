extends State
@export var idle_state: State

@onready var creasing_jays = $CreasingJays

func enter() -> void:
	find_direction()
	creasing_jays.play()
	
func process_physics(delta: float) -> State:
	parent.velocity = Vector2(0,0)
	return idle_state
