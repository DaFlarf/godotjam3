extends CanvasLayer

var time = Global.speedrun_time

@onready var player: CharacterBody2D = get_tree().current_scene.get_node("player")

func _physics_process(delta: float) -> void:
	time = float(time) + delta
	
	update_ui()
	
func update_ui():
	
	var formatted_time = str(time)
	var decimal_index = formatted_time.find(".")
	
	if decimal_index > 0:
		formatted_time = formatted_time.left(decimal_index + 3)
		
	Global.speedrun_time = formatted_time
	
	$Label.text = formatted_time
	if player != null:
		$health_label.text = str(player.health)
		$wealth_label.text = str(player.cash)
		var can: bool = player.can_combine()
		if can:
			$combine_label.show()
		else:
			$combine_label.hide()
