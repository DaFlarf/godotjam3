extends Node2D
class_name Main_menu

var scene_changer = load(Util.SCENE_CHANGER_PATH).instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.main = self
	add_child(scene_changer)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	scene_changer.change_to(Util.GAME_SCENES.GAME)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		scene_changer.change_to(Util.GAME_SCENES.GAME)
