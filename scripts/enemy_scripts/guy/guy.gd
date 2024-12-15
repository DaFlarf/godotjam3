extends Enemy

const MAX_RANGE: int = 256
const SWORD_RANGE: int = 144

const BAT_SCENE: PackedScene = preload("res://scenes/enemy_scenes/bat/bat.tscn")
#const HOMING_SHELL_SCENE: PackedScene = preload("res://scenes/enemy_scenes/guy/attacks/homing_shell.tscn")

@onready
var hitbox_right = $Hitbox
@onready
var hitbox_left = $Hitbox2
@onready
var attack_timer = $AttackCooldown

var can_attack = true

func _ready() -> void:
	super()
	hitbox_right.set_deferred("monitoring", false)
	hitbox_left.set_deferred("monitoring", false)

func take_damage(damage: int, knockback_direction: Vector2, knockback_force: int, hitstun: float):
	if !invincible and !ded:
		damage_to_take = damage
		direction_of_knockback = knockback_direction
		knockback_to_take = knockback_force
		hitstun_to_take = hitstun/3
		stunned = true
		velocity += direction_of_knockback * knockback_to_take
		state_machine.change_state(state_machine.hitstun_state)

func summon_bat():
	var bat: Node2D = BAT_SCENE.instantiate()
	bat.position = global_position + Vector2.DOWN * 128
	get_tree().current_scene.add_child(bat)

#func summon_shell():
	#var projectile: Node2D = HOMING_SHELL_SCENE.instantiate()
	#projectile.launch(global_position, player, 50)
	#get_tree().current_scene.add_child(projectile)

func swing_sword():
	if dir == "_left" or dir == "_down":
		hitbox_left.set_deferred("monitoring", true)
	else:
		hitbox_right.set_deferred("monitoring", true)
	

func _on_attack_cooldown_timeout() -> void:
	can_attack = true

func die():
	state_machine_disabled = true
	animations.play("ded_down")
	animations.connect("animation_finished", func f():
		emit_signal("victory")
		queue_free()
		)


func _on_sword_time_timeout() -> void:
	hitbox_left.set_deferred("monitoring", false)
	hitbox_right.set_deferred("monitoring", false)
