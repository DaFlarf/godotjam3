extends room

const PURPLE_SCENE: PackedScene = preload("res://scenes/enemy_scenes/purple_knight/purple.tscn")

@onready
var guy_position = $guyposition


func _on_area_2d_body_entered(body: Player) -> void:
	var guy: Node2D = PURPLE_SCENE.instantiate()
	guy.position = guy_position.global_position
	get_tree().current_scene.add_child(guy)
