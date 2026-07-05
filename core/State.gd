class_name State

var should_exit: bool = false

func _init(_context: Context) -> void:
	pass

func enter() -> void:
	pass

func process(_delta: float) -> void:
	pass

func exit() -> State:
	return null
