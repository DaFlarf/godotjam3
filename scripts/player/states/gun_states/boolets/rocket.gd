extends Node2D

var direction: Vector2 = Vector2.ZERO
var knife_speed: int = 0

@onready var hitbox = $Area2D

func launch(intitial_position: Vector2, dir: Vector2, speed: int) -> void:
	position = intitial_position
	direction = dir
	knife_speed = speed
	
	rotation = dir.angle()
	
func _physics_process(delta: float) -> void:
	position += direction * knife_speed * delta
	hitbox.knockback_direction = direction.normalized()


func _on_area_2d_hit() -> void:
	queue_free()


func _on_simple_collsion_body_entered(body: TileMapLayer) -> void:
	queue_free()
