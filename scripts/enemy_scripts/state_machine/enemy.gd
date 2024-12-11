class_name Enemy
extends CharacterBody2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var animations: AnimatedSprite2D = $animations
@onready var move_component: Node = $move_component
@onready var state_machine: Node = $state_machine
@onready var player: CharacterBody2D = get_tree().current_scene.get_node("player")
var dir: String = "_right"

func _ready() -> void:
	#set up state machine
	state_machine.init(self, animations, move_component)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func target(pos: Vector2) -> Vector2:
	navigation_agent_2d.target_position = pos
	
	var current_agent_position = global_position
	var next_path_position = navigation_agent_2d.get_next_path_position()
	var target_direction = current_agent_position.direction_to(next_path_position)
	return target_direction

func use_velocity(new_velocity: Vector2):
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.set_velocity(new_velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(new_velocity)

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
