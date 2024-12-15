extends Node2D
class_name room

const SPAWN_EXPLOSION_SCENE: PackedScene = preload("res://scenes/enemy_scenes/effects/spawn_explosion.tscn")
const WALL_SCENE: PackedScene = preload("res://scenes/room_scenes/wall.tscn")

var ENEMY_SCENES: Dictionary = {
	"CAMPYKNIGHT": preload("res://scenes/enemy_scenes/campy_knight/campy_knight.tscn"),
	"SHOTGUNKNIGHT": preload("res://scenes/enemy_scenes/shotgun_knight/shotgun_knight.tscn"),
	"BAT": preload("res://scenes/enemy_scenes/bat/bat.tscn")
}

var num_enemies: int
var room_beaten = false

@onready var tilemap: TileMapLayer = get_node("bottom walls")
@onready var door_container: Node2D = get_node("Doors")
@onready var enemy_positions_container: Node2D = get_node("EnemyPositions")
@onready var player_detector: Area2D = get_node("PlayerDetector")
@onready var exit_detector: Area2D = get_node("ExitZones")
@onready var entrance: Node2D = get_node("Entrance")
@onready var wall_container: Node2D = get_node("Walls")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	num_enemies = enemy_positions_container.get_child_count()
	player_detector.set_deferred("monitoring", true)
	exit_detector.set_deferred("monitoring", false)

func _on_enemy_left() -> void:
	num_enemies -= 1
	if num_enemies <= 0:
		_open_doors()
		_remove_walls()

func _on_enemy_killed() -> void:
	num_enemies -= 1
	if num_enemies <= 0:
		room_beaten = true
		_open_doors()
		_remove_walls()

func _open_doors() -> void:
	if room_beaten:
		for door in door_container.get_children():
			door.open()
	for wall in wall_container.get_children():
		wall.queue_free()

func _close_entrance() -> void:
	for entry_position in entrance.get_children():
		var wall: StaticBody2D = WALL_SCENE.instantiate()
		#wall_container.add_child(wall)
		wall_container.call_deferred("add_child", wall)
		wall.global_position = entry_position.position

func _remove_walls():
	for wall in wall_container.get_children():
		wall.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _spawn_enemies() -> void:
	for enemy_position in enemy_positions_container.get_children():
		var enemy: CharacterBody2D 
		var rand = randi_range(0, 2)
		if  rand == 0:
			enemy = ENEMY_SCENES.BAT.instantiate()
		elif rand == 1:
			enemy = ENEMY_SCENES.SHOTGUNKNIGHT.instantiate()
		else:
			enemy = ENEMY_SCENES.CAMPYKNIGHT.instantiate()
		var __ = enemy.connect("leaving", func f():
			_on_enemy_left())
		var ___ = enemy.connect("dead", func f():
			_on_enemy_killed())
		enemy.position = enemy_position.position
		call_deferred("add_child", enemy)
		
		var spawn_explosion: AnimatedSprite2D = SPAWN_EXPLOSION_SCENE.instantiate()
		spawn_explosion.position = enemy_position.position
		call_deferred("add_child", spawn_explosion)


func _on_player_detector_body_entered(body: CharacterBody2D) -> void:
	player_detector.set_deferred("monitoring", false)
	exit_detector.set_deferred("monitoring", true)
	if num_enemies > 0:
		if (room_beaten == false):
			_close_entrance()
		_spawn_enemies()
	else:
		_open_doors()

func _reset():
	num_enemies = enemy_positions_container.get_child_count()
	player_detector.set_deferred("monitoring", true)


func _on_exit_zones_body_entered(body: CharacterBody2D) -> void:
	Events.emit_signal("player_ran_away")
	_reset()
