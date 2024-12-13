extends Node2D

var scene_changer = load(Util.SCENE_CHANGER_PATH).instantiate()

func _ready() -> void:
	add_child(scene_changer)
	Events.connect("game_over", func f():
		scene_changer.change_to(Util.GAME_SCENES.MAIN))
