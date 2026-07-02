extends Node

const PLAYER_SCENE: PackedScene = preload("res://player/player.tscn")

@onready var level_root: Node3D = $World/Levels
@onready var entity_root: Node3D = $World/Entities

var level: Level = null
var player: Player = null


func _ready() -> void:
	change_level("res://levels/Test.tscn")


func change_level(path: String) -> void:
	if level:
		level.queue_free()

	var scene: PackedScene = load(path) as PackedScene
	level = scene.instantiate() as Level
	level_root.add_child(level)

	if not player:
		player = PLAYER_SCENE.instantiate() as Player
		entity_root.add_child(player)

	player.teleport(level.get_player_spawn_pos())
