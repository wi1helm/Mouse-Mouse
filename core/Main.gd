extends Node

var current_state: State = null

func _ready() -> void:
	# get the ui node using string refrence
	var ui_node: CanvasLayer = $UI
	if (ui_node == null): return
	
	# Create the context structure using our target layer
	# Pass the configured context directly into our starting state
	current_state = StartState.new(StartContext.new(ui_node))
	if (current_state == null): return
		
	# Initialize our newly created state loop
	current_state.enter()

func _process(delta: float) -> void:
	# if no state do nothing. (exit the program i guess)
	if (current_state == null):
		get_tree().quit()
		return
		
	# run the state process.
	current_state.process(delta)
	# return early if current state should stay to next frame
	if (!current_state.should_exit): return
	
	# get new state and enter if not null
	var new_state: State = current_state.exit()

	current_state = new_state
	if (new_state == null): return
	current_state.enter()
