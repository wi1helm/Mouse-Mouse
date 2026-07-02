class_name Test
extends Level

@onready var spawn_marker: Marker3D = $SpawnPoint

func get_player_spawn_pos() -> Vector3:
	return spawn_marker.global_position
