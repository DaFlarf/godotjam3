extends Node2D



func _on_area_2d_body_entered(body: Player) -> void:
	if body != null:
		if body.has_blue_key and body.has_red_key:
			queue_free()
