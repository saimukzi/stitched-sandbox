extends Node

var camera : XRCamera3D
var xr_enabled : bool = false
var screen_size : Vector2i

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	G.xr_enabled = (OS.get_name()=="Android")
	screen_size = DisplayServer.screen_get_size()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
