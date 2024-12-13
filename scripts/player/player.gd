class_name Player
extends CharacterBody2D

@onready
var animations = $animations
@onready
var state_machine = $state_machine
@onready
var move_component = $move_component

var slide_cancel = false
var dash_cancel = false
var dir: String = "_right"
var has_red_key = false
var has_blue_key = false

@export var health: int = 30

var weapon_array: PackedStringArray = PackedStringArray(["pistol"])
var offhand_weapon: String = "none"

func _ready() -> void:
	#set up state machine
	state_machine.init(self, animations, move_component)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)	
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func calculate_upgrade_cost() -> int:
	return weapon_array.size() * 300

func swap_offhand_weapon(new_weapon: String) -> void:
	offhand_weapon = new_weapon

func combine_weapons() -> void:
	if offhand_weapon != "none":
		if weapon_array.size() < 4:
			weapon_array.append(offhand_weapon)
	else:
		Events.emit_signal("unable_to_combine")
	offhand_weapon = "none"
