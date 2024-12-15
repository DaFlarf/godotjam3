extends Node
class_name Gun_state

@export
var gun_name: String
@export
var projectile_scene: PackedScene

var dir: String
var move_component
var gun_animations: AnimatedSprite2D
var weapon_array: Array
var offhand_weapon: Gun_state
var parent: CharacterBody2D

var is_offhand = false
var num_in_series = 1

@export var time_to_shoot: float = 0.0
var shoot_timer: float
@export var endlag: float = 0.0
var lag_timer: float


func enter():
	shoot_timer = time_to_shoot
	weapon_array = parent.weapon_array
	offhand_weapon = parent.offhand_weapon
	
func exit():
	pass

func process_input(event: InputEvent) -> Gun_state:
	return null

func process_frame(delta: float) -> Gun_state:
	return null

func process_physics(delta: float) -> Gun_state:
	change_animation()
	return null

func change_animation() -> void:
	find_direction()
	if dir == "_left" or dir == "_down":
		gun_animations.z_index = 2
	else:
		gun_animations.z_index = 1
	gun_animations.play(dir + gun_name)

func find_direction() -> void:
	dir = parent.dir
