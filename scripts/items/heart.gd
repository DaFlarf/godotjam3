extends Area2D

func _on_body_entered(body: Player) -> void:
	body.health += 1
	queue_free()
