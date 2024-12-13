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

@export var health: int = 30

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

func _ready() -> void:
	#set up state machine
	state_machine.init(self, animations, move_component)
	gun_state_machine.init(self, other_animations, move_component)
	weapon_array.append(gun_state_machine.starting_state)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)	
	gun_state_machine.process_input(event)
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	gun_state_machine.process_physics(delta)
	if ((health <= 0) and (state_machine.current_state != state_machine.death_state)):
		state_machine.change_state(state_machine.death_state)
	
func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	gun_state_machine.process_frame(delta)

func calculate_upgrade_cost() -> int:
	return weapon_array.size() * 300

func swap_offhand_weapon(new_weapon: Gun_state) -> void:
	offhand_weapon = new_weapon

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
	if !invincible:
		damage_to_take = damage
		direction_of_knockback = knockback_direction
		knockback_to_take = knockback_force
		hitstun_to_take = hitstun
		stunned = true
		velocity += direction_of_knockback * knockback_to_take
		state_machine.change_state(state_machine.hitstun_state)



func _on_animations_animation_finished() -> void:
	if ded:
		Events.emit_signal("game_over")
		queue_free()
