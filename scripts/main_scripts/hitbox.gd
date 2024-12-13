class_name Hitbox
extends Area2D

@export var damage: int = 1
var knockback_direction: Vector2 = Vector2.ZERO
@export var knockback_force: int = 300
@export var hitstun: float = 1
@export var targeted_group: String = "player"

@onready var collision_shape: CollisionShape2D = get_child(0)

func _ready() -> void:
	assert(collision_shape != null)

func _on_body_entered(body) -> void:
	if body.is_in_group(targeted_group):
		body.take_damage(damage, knockback_direction, knockback_force, hitstun)
	
