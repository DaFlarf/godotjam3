extends Node2D

var direction: Vector2 = Vector2.ZERO
var knife_speed: int = 0
var distance_traveled = 0
var starting_pos

@export var max_distance: float = 256

@onready var hitbox = $Area2D

func launch(intitial_position: Vector2, dir: Vector2, speed: int) -> void:
	position = intitial_position
	starting_pos = intitial_position
	direction = dir
	knife_speed = speed
	
	rotation = dir.angle()
	
func _physics_process(delta: float) -> void:
	position += direction * knife_speed * delta
	hitbox.knockback_direction = direction.normalized()
	distance_traveled = (position - starting_pos).length()
	if distance_traveled >= max_distance:
		queue_free()


func _on_area_2d_hit() -> void:
	queue_free()
