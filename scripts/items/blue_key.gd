extends Area2D

@onready var audio = $AudioStreamPlayer

func _on_body_entered(body: Player) -> void:
	print("I see you")
	if body != null:
		body.has_blue_key = true
		audio.play()

func _on_audio_stream_player_finished() -> void:
	queue_free()
