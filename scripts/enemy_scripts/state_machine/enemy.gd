class_name Enemy
extends CharacterBody2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var animations: AnimatedSprite2D = $animations
@onready var move_component: Node = $move_component
@onready var state_machine: Node = $state_machine
@onready var player: CharacterBody2D = get_tree().current_scene.get_node("player")

const HEART_SCENE: PackedScene = preload("res://scenes/items/heart.tscn")
const PISTOL_SCENE: PackedScene = preload("res://scenes/items/pistolPickup.tscn")
const AK_SCENE: PackedScene = preload("res://scenes/items/AKPickup.tscn")
const MP7_SCENE: PackedScene = preload("res://scenes/items/MP7Pickup.tscn")
const ROCKET_SCENE: PackedScene = preload("res://scenes/items/rocketPickup.tscn")
const SHOTGUN_SCENE: PackedScene = preload("res://scenes/items/shotgunPickup.tscn")
const SNIPER_SCENE: PackedScene = preload("res://scenes/items/sniperPickup.tscn")
const GOLD_SCENE: PackedScene = preload("res://scenes/items/gold.tscn")

var dir: String = "_right"

#variables that are used to cause the player to take damage
var damage_to_take: int = 0
var direction_of_knockback: Vector2 = Vector2.ZERO
var knockback_to_take: int = 0
var hitstun_to_take: float = 0.0
var stunned = false
var invincible = false
var ded = false
var state_machine_disabled = false

@export var health: int = 30

signal leaving
signal dead

func _ready() -> void:
	#set up state machine
	state_machine.init(self, animations, move_component)
	Events.player_ran_away.connect(func():
		delete_self()
		)
	Events.kill.connect(func():
		die())

func delete_self():
	emit_signal("leaving")
	queue_free()

func die():
	$collision.disabled = true
	state_machine_disabled = true
	animations.play("ded_down")
	animations.connect("animation_finished", func f():
		emit_signal("dead")
		randomize()
		var rand = randi_range(0, 2)
		if  rand == 0:
			var health_drop = HEART_SCENE.instantiate()
			health_drop.global_position = global_position
			get_tree().current_scene.add_child(health_drop)
		elif rand == 1:
			rand = randi_range(0, 5)
			var drop
			match rand:
				0:
					drop = AK_SCENE.instantiate()	
				1:
					drop = MP7_SCENE.instantiate()
				2:
					drop = PISTOL_SCENE.instantiate()
				3:
					drop = ROCKET_SCENE.instantiate()
				4: 
					drop = SHOTGUN_SCENE.instantiate()
				5:
					drop = SNIPER_SCENE.instantiate()
			drop.global_position = global_position
			get_tree().current_scene.add_child(drop)
		else:
			var gold_drop = GOLD_SCENE.instantiate()
			gold_drop.global_position = global_position
			get_tree().current_scene.add_child(gold_drop)
		queue_free()
		)
	
	
func _physics_process(delta: float) -> void:
	if !state_machine_disabled:
		state_machine.process_physics(delta)
		if ((health <= 0) and (state_machine.current_state != state_machine.death_state)):
			state_machine.change_state(state_machine.death_state)
	
func _process(delta: float) -> void:
	if !state_machine_disabled:
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

func take_damage(damage: int, knockback_direction: Vector2, knockback_force: int, hitstun: float):
	if !invincible and !ded:
		damage_to_take = damage
		direction_of_knockback = knockback_direction
		knockback_to_take = knockback_force
		hitstun_to_take = hitstun
		stunned = true
		velocity += direction_of_knockback * knockback_to_take
		state_machine.change_state(state_machine.hitstun_state)
