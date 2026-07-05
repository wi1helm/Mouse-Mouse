class_name StartContext
extends Context

var _ui_layer: CanvasLayer

func _init(ui_layer: CanvasLayer) -> void:
	super(String("StartContext"))
	_ui_layer = ui_layer

func get_ui_layer() -> CanvasLayer:
	return _ui_layer
