class_name State
extends Node

@export
var animation_name: String
@export
var move_speed: float = 300

var dir: String
var directional_input: bool

# Hold a reference to the parent so that it can be controlled by the state
var parent: CharacterBody2D
var animations: AnimatedSprite2D
var move_component

func enter() -> void:
	update_animation()

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func get_movement_input() -> Vector2:
	return move_component.get_movement_direction()
	
func update_animation():
	animations.play(animation_name + dir)
	
func find_direction() -> void:
	var movement_dir = get_movement_input()
	if movement_dir.x < 0: dir = "_left"
	elif movement_dir.x > 0: dir = "_right"
	elif movement_dir.y < 0: dir = "_up"
	elif movement_dir.y > 0: dir = "_down"
	else:
		dir = parent.dir
	update_animation()
	parent.dir = dir
