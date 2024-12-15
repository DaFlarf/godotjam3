class_name Gun_pickup
extends Area2D

var gun_state: Gun_state
@onready var player = get_tree().current_scene.get_node("player")


func _physics_process(delta: float) -> void:
	if player != null:
		if overlaps_body(player):
			if Input.is_action_just_pressed("interact"):
				player.swap_offhand_weapon(gun_state)
				queue_free()
