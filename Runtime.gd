extends Node

@export var camera : NodePath
var xr_enabled : bool = false
var mouse_capture : bool = false
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = DisplayServer.screen_get_size()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action("mouse_capture_enable"):
		mouse_capture = true
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action("mouse_capture_disable"):
		mouse_capture = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
