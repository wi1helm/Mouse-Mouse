# Main.gd — stays exactly this slim, forever
extends Node

var current_state: State = null
var context: Context = Context.new()

func _ready() -> void:
	context.ui_layer = $UI
	context.levels = $World/Levels
	context.entities = $World/Entities
	context.effects = $World/Effects

	#current_state = StartState.new(context)
	current_state = MainMenuState.new(context)
	current_state.enter()

func _process(delta: float) -> void:
	if current_state == null:
		get_tree().quit()
		return

	current_state.process(delta)
	if not current_state.should_exit:
		return

	var new_state: State = current_state.exit()
	current_state = new_state
	if new_state == null:
		return
	current_state.enter()
