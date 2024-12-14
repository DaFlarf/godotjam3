class_name Player
extends CharacterBody2D

#other nodes within the scene
@onready
var animations = $animations
@onready 
var other_animations = $gun_animations
@onready
var state_machine = $state_machine
@onready
var move_component = $move_component
@onready
var gun_state_machine = $gun_state_machine
@onready
var hurtbox = $Area2D

#stuff that states and certain area2d's check
var slide_cancel = false
var dash_cancel = false
var dir: String = "_right"
var has_red_key = false
var has_blue_key = false

@export_group("life force")
@export var health: int = 30

@export_group("gun states")
@export var first_gun_state: Gun_state
@export var pistol_state: Gun_state
@export var shotgun_state: Gun_state
@export var AK_state: Gun_state
@export var MP7_state: Gun_state
@export var Rocket_launcher_state: Gun_state
@export var sniper_state: Gun_state

@export_group("bullet scenes")
@export var pistol_boolet_scene: PackedScene
@export var pistol_boolet_speed: int

#variables that are used to cause the player to take damage
var damage_to_take: int = 0
var direction_of_knockback: Vector2 = Vector2.ZERO
var knockback_to_take: int = 0
var hitstun_to_take: float = 0.0
var stunned = false
var invincible = false
var ded = false

var weapon_array: Array
var offhand_weapon: Gun_state = null
var using_primary = false
var using_offhand = false
var num_in_series = 0

var last_non_zero_direction: Vector2 = Vector2(1,0)

var state_machine_disabled = false

func _ready() -> void:
	#set up state machine
	state_machine.init(self, animations, move_component)
	gun_state_machine.init(self, other_animations, move_component)
	weapon_array.append(first_gun_state)

func _unhandled_input(event: InputEvent) -> void:
	if !state_machine_disabled:
		state_machine.process_input(event)	
		gun_state_machine.process_input(event)
	
func _physics_process(delta: float) -> void:
	if !state_machine_disabled:
		state_machine.process_physics(delta)
		gun_state_machine.process_physics(delta)
		if ((health <= 0)):
			state_machine.change_state(state_machine.death_state)
			ded = true
	
func _process(delta: float) -> void:
	if !state_machine_disabled:
		state_machine.process_frame(delta)
		gun_state_machine.process_frame(delta)

func calculate_upgrade_cost() -> int:
	return weapon_array.size() * 300

func swap_offhand_weapon(new_weapon: Gun_state) -> void:
	if !state_machine_disabled:
		gun_state_machine.change_state(gun_state_machine.starting_state)
		offhand_weapon = new_weapon
		print(offhand_weapon)

func combine_weapons() -> void:
	if (offhand_weapon != null) and weapon_array.size() < 4:
		weapon_array.append(offhand_weapon)
	else:
		Events.emit_signal("unable_to_combine")
	offhand_weapon = null

func disable_hurtbox():
	invincible = true

func enable_hurtbox():
	invincible = false

func take_damage(damage: int, knockback_direction: Vector2, knockback_force: int, hitstun: float):
	if !invincible and !ded:
		damage_to_take = damage
		direction_of_knockback = knockback_direction
		knockback_to_take = knockback_force
		hitstun_to_take = hitstun
		stunned = true
		velocity += direction_of_knockback * knockback_to_take
		state_machine.change_state(state_machine.hitstun_state)

func die():
	state_machine_disabled = true
	var pure_agony = $PureAgony
	pure_agony.play()
	animations.play("ded_down")
	animations.connect("animation_finished", func f():
		Events.emit_signal("game_over")
		queue_free()
		)

func spawn_pistol_boolet():
	var projectile: Node2D = pistol_boolet_scene.instantiate()
	projectile.launch(global_position, last_non_zero_direction.normalized(), pistol_boolet_speed)
	get_tree().current_scene.add_child(projectile)
