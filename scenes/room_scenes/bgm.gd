extends Node2D

@onready
var opening_theme = $opening_theme
@onready
var theme_of_guy = $theme_of_guy
@onready var opening_theme_trigger = $opening_theme_trigger
@onready var theme_of_guy_trigger = $theme_of_guy_trigger

func _on_opening_theme_trigger_body_entered(body: Player) -> void:
	opening_theme.play()
	theme_of_guy.stop()
	opening_theme_trigger.set_deferred("monitoring", false)
