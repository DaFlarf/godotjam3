extends StaticBody2D

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

func open() -> void:
	animation_player.play("open")

func close() -> void:
	animation_player.play("lock")
