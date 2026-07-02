class_name Level
extends Node3D

# "Abstract" - must be overridden by each level script.
func get_player_spawn_pos() -> Vector3:
	push_error("get_player_spawn_pos() not implemented in %s" % get_script().get_path())
	return Vector3.ZERO
