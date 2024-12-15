extends Node2D

var direction: Vector2 = Vector2.ZERO
var speed: int = 0
var target: Player

@onready var hitbox = $Area2D

func launch(intitial_position: Vector2, playa: Player, speed: int) -> void:
	if playa != null:
		position = intitial_position
		direction = (playa.position - global_position).normalized()
		target = playa
		speed = speed
	
	rotation = direction.angle()
	
func _physics_process(delta: float) -> void:
	if target != null:
		direction = (target.position - global_position).normalized()
		position += direction * speed * delta
		hitbox.knockback_direction = direction.normalized()


func _on_area_2d_hit() -> void:
	queue_free()
