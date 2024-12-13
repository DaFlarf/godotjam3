extends CanvasLayer


var new_scene_path: String

func _ready() -> void:
	$ColorRect.hide()

func change_to(new_scene: Util.GAME_SCENES):
	print("change_to ", new_scene)
	match new_scene:
		Util.GAME_SCENES.MAIN:
			new_scene_path = Util.MAIN_MENU_PATH
		Util.GAME_SCENES.GAME:
			new_scene_path = Util.GAME_PATH
	
	$ColorRect.show()
	if $AnimationPlayer.is_playing():
		$AnimationPlayer.stop()
	$AnimationPlayer.play("Fade In Out")

func _new_scene():
	$ColorRect.hide()
	get_tree().call_deferred("change_scene_to_file", new_scene_path)
