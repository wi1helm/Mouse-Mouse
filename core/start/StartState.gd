class_name StartState
extends State

# Hardcoded path to scene so it can be loaded on demand
const START_SCREEN_SCENE = preload("res://core/start/StartScreen.tscn")

var screen_instance: Control = null
var animation_player: AnimationPlayer = null
var context: Context = null

func _init(context: Context) -> void:
	if (context == null): return
	self.context = context;
	
func enter() -> void:
	# Load the start scene
	self.screen_instance = START_SCREEN_SCENE.instantiate() as Control
	if (screen_instance == null):
		should_exit = true
		return
	
	# Add start screen to ui layer
	context.ui_layer.add_child(screen_instance)
	
	# Get the animator
	animation_player = screen_instance.get_node_or_null("AnimationPlayer")
	if (animation_player == null):
		should_exit = true
		return
		
	# Kick off our sequential timeline logic split into a helper function
	_run_sequence()

func _run_sequence() -> void:
	# Early exit safety check
	if (animation_player == null):
		should_exit = true
		return
		
	# Play start credits animation and wait for it to finish
	if (animation_player.has_animation("start_credits")):
		animation_player.play("start_credits")
		await animation_player.animation_finished
	
	# Small break between animations using the scene's tree
	await screen_instance.get_tree().create_timer(0.5).timeout
	
	# Safety check in case the game was closed or state changed during the wait
	if (animation_player == null): return

	# Play start title animation and wait for it to finish
	if (animation_player.has_animation("start_title")):
		animation_player.play("start_title")
		await animation_player.animation_finished
	
	# Finished everything!
	should_exit = true

func process(_delta: float) -> void:
	pass

func exit() -> State:
	# Clean up and free the instantiated scene when moving away from this state
	if (screen_instance != null):
		screen_instance.queue_free()
	return MainMenuState.new(self.context)
