extends Node

var xr_enabled : bool = false
var screen_size : Vector2i
var world_node : Node3D
var camera_global_position_4i : Vector3

const PHI: float = (1+5**0.5)/2

var d = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	G.xr_enabled = (OS.get_name()=="Android")
	screen_size = DisplayServer.screen_get_size()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var camera = get_viewport().get_camera_3d()
	camera_global_position_4i = (camera.global_position/4).floor()*4

func set_weak(key, val) -> void:
	d[key] = weakref(val)

func get_weak(key):
	if not d.has(key): return null
	var ret = d[key].get_ref()
	if ret != null: return ret
	d.erase(key)
	return null
