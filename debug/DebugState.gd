class_name DebugState
extends State

const TEST_LEVEL_SCENE = preload("res://debug/Test.tscn")
const PLAYER_SCENE = preload("res://player/Player.tscn")

var context: Context = null
var level_instance: Level = null
var player_instance: Player = null

func _init(game_context: Context) -> void:
	context = game_context

func enter() -> void:
	if is_null(context, "DebugState: context is null"): return

	level_instance = TEST_LEVEL_SCENE.instantiate() as Level
	if is_null(level_instance, "DebugState: failed to instantiate TEST_LEVEL_SCENE"): return
	context.levels.add_child(level_instance)

	player_instance = PLAYER_SCENE.instantiate() as Player
	if is_null(player_instance, "DebugState: failed to instantiate PLAYER_SCENE"): return
	context.entities.add_child(player_instance)
	player_instance.teleport(level_instance.get_player_spawn_pos())

func process(_delta: float) -> void:
	pass

func exit() -> State:
	if level_instance != null:
		level_instance.queue_free()
	if player_instance != null:
		player_instance.queue_free()
	return null
