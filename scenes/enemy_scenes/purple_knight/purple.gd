extends Enemy

const THROWABLE_KNIFE_SCENE: PackedScene = preload("res://scenes/enemy_scenes/bat/bat.tscn")
const shotgun_boolet_scene: PackedScene = preload("res://scenes/enemy_scenes/shotgun_knight/shotgun_shell.tscn")

const MAX_DISTANCE_TO_PLAYER: int = 256
const MIN_DISTANCE_TO_PLAYER: int = 144

@onready var attack_timer = $AttackTimer
@onready var attack_timer2 = $AttackTimer2
var projectile_speed: int = 200

var can_attack: bool = true
var can_shoot: bool = true

func _process(delta: float) -> void:
	if !state_machine_disabled:
		super(delta)
		if stunned:
			attack_timer.paused = true
		else:
			attack_timer.paused = false

func _throw_knife() -> void:
	var projectile: Node2D = THROWABLE_KNIFE_SCENE.instantiate()
	projectile.position = global_position
	get_tree().current_scene.add_child(projectile)

func shoot_shotgun():
	var projectile: Node2D = shotgun_boolet_scene.instantiate()
	projectile.launch(global_position, (player.position - global_position).normalized(), projectile_speed)
	get_tree().current_scene.add_child(projectile)
	var projectile2: Node2D = shotgun_boolet_scene.instantiate()
	projectile2.launch(global_position, ((player.position - global_position).rotated(PI/16).normalized()), projectile_speed)
	get_tree().current_scene.add_child(projectile2)
	var projectile3: Node2D = shotgun_boolet_scene.instantiate()
	projectile3.launch(global_position, ((player.position - global_position).rotated(-PI/16).normalized()), projectile_speed)
	get_tree().current_scene.add_child(projectile3)

func _on_attack_timer_timeout() -> void:
	can_attack = true

func die():
	$collision.disabled = true
	state_machine_disabled = true
	animations.play("ded_down")
	animations.connect("animation_finished", func f():
		Events.emit_signal("victory")
		queue_free()
	)


func _on_attack_timer_2_timeout() -> void:
	can_shoot = true
