extends Enemy

const THROWABLE_KNIFE_SCENE: PackedScene = preload("res://scenes/enemy_scenes/campy_knight/attacks/Throwable_knife.tscn")

const MAX_DISTANCE_TO_PLAYER: int = 256
const MIN_DISTANCE_TO_PLAYER: int = 144

@export
var projectile_speed: int = 150

@onready var attack_timer = $AttackTimer

var can_attack: bool = true

func _process(delta: float) -> void:
	if !state_machine_disabled:
		super(delta)
		if stunned:
			attack_timer.paused = true
		else:
			attack_timer.paused = false

func _throw_knife() -> void:
	var projectile: Node2D = THROWABLE_KNIFE_SCENE.instantiate()
	projectile.launch(global_position, (player.position - global_position).normalized(), projectile_speed)
	get_tree().current_scene.add_child(projectile)

func _on_attack_timer_timeout() -> void:
	can_attack = true
