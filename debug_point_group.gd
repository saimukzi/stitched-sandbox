extends Node3D

const RADIUS:int = 8

const debug_unit_tscn = preload("res://DebugUnit.tscn")

var camera_global_position_i : Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ref_pos = Vector3.ONE * 0.5
	for x in range(-RADIUS,RADIUS+1): for y in range(-RADIUS,RADIUS+1): for z in range(-RADIUS,RADIUS+1):
		var debug_unit_node = debug_unit_tscn.instantiate()
		var related_position = Vector3(x,y,z)
		if (related_position-ref_pos).length() > RADIUS: continue
		debug_unit_node.related_position = related_position
		#debug_unit_node.position = Vector3(x,y,z)
		self.add_child(debug_unit_node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var camera = get_viewport().get_camera_3d()
	camera_global_position_i = camera.global_position.floor()
