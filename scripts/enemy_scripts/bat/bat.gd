extends Enemy

@onready var hitbox = $Area2D

func _process(delta: float) -> void:
	if !ded:
		hitbox.knockback_direction = velocity.normalized()
