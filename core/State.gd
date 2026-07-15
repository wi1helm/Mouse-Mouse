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

# Returns true if value is null. Logs + flags should_exit if not.
func is_null(value: Object, message: String) -> bool:
	if value == null:
		push_error(message)
		should_exit = true
	return value == null
	
