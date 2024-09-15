extends Node3D

const debug_line_tscn = preload("res://components/debug/debug_line/debug_line.tscn")

var camera_global_position_4i : Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	camera_global_position_4i = (camera.global_position/4).floor()*4
