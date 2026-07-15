class_name MainMenuState
extends State

const MENU_BACKGROUND_SCENE = preload("res://core/menu/MainMenuBackground.tscn")
const MENU_UI_SCENE = preload("res://core/menu/MainMenuUI.tscn")

# The next state to enter when this state exits
var next_state: State = null
var context: Context = null

# Scene instances of background and UI
var background_instance: Node3D = null
var ui_instance: Control = null

# Menu Buttons
var new_game_button: Button = null
var exit_game_button: Button = null

func _init(context: Context) -> void:
	self.context = context

func enter() -> void:
	if is_null(context, "MainMenuState: cannot enter, context is null"): return

	self.background_instance = MENU_BACKGROUND_SCENE.instantiate() as Node3D
	if is_null(background_instance, "MainMenuState: failed to instantiate MENU_BACKGROUND_SCENE"): return
	context.levels.add_child(background_instance)

	self.ui_instance = MENU_UI_SCENE.instantiate() as Control
	if is_null(ui_instance, "MainMenuState: failed to instantiate MENU_UI_SCENE"): return
	context.ui_layer.add_child(ui_instance)

	self.new_game_button = ui_instance.get_node_or_null("NewGame")
	if is_null(new_game_button, "MainMenuState: Button node named \"NewGame\" does not exist"): return
	# Connect the button press to a function
	new_game_button.pressed.connect(_on_new_game_pressed)
	
	self.exit_game_button = ui_instance.get_node_or_null("ExitGame")
	if is_null(exit_game_button, "MainMenuState: Button node named \"ExitGame\" does not exist"): return
	# Connect the button press to a function
	exit_game_button.pressed.connect(_on_exit_game_pressed)
func process(_delta: float) -> void:
	pass

func exit() -> State:
	if (background_instance != null): background_instance.queue_free()
	if (ui_instance != null): ui_instance.queue_free()
	return next_state
	
	
func _on_new_game_pressed() -> void:
	self.next_state = DebugState.new(context)
	should_exit = true
	
func _on_exit_game_pressed() -> void:
	self.next_state = null
	should_exit = true
	
	
