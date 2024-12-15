extends Area2D

@onready var audio = $AudioStreamPlayer

func _on_body_entered(body: Player) -> void:
	if body != null:
		body.has_red_key = true
		audio.play()

func _on_audio_stream_player_finished() -> void:
	queue_free()
