extends Node

signal mouse_capture_enabled
signal mouse_capture_disabled
signal mouse_motion(event)

var mouse_capture : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
	if mouse_capture and (event is InputEventMouseMotion):
		mouse_motion.emit(event)
