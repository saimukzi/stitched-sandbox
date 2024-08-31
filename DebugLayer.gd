extends Node3D

const RADIUS:int = 8

const debug_unit_tscn = preload("res://DebugUnit.tscn")
const debug_line_tscn = preload("res://debug_line.tscn")

var camera_global_position_i : Vector3
var camera_global_position_4i : Vector3

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
	
	for i in range(-8,16,4): for j in range(-8,16,4):
		var debug_line_node
		debug_line_node = debug_line_tscn.instantiate()
		debug_line_node.axis = debug_line_node.Axis.X
		debug_line_node.offset = Vector3i(2,i,j)
		self.add_child(debug_line_node)

		debug_line_node = debug_line_tscn.instantiate()
		debug_line_node.axis = debug_line_node.Axis.Y
		debug_line_node.offset = Vector3i(i,2,j)
		self.add_child(debug_line_node)

		debug_line_node = debug_line_tscn.instantiate()
		debug_line_node.axis = debug_line_node.Axis.Z
		debug_line_node.offset = Vector3i(i,j,2)
		self.add_child(debug_line_node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var camera = get_viewport().get_camera_3d()
	camera_global_position_i = camera.global_position.floor()
	camera_global_position_4i = (camera.global_position/4).floor()*4
