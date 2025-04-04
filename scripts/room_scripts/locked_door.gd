class_name Locked_door
extends StaticBody2D

@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

func open() -> void:
	animation_player.play("open")
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()

func _on_area_2d_area_entered(body: Player) -> void:
	if body.has_red_key and body.has_blue_key:
		open()
