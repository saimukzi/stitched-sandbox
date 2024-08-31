extends Node3D

const debug_coor_tscn = preload("res://debug_coor.tscn")

var camera_global_position_4i:Vector3i

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(-2,10,4): for j in range(-2,10,4): for k in range(0,12,4):
		var debug_coor_node

		debug_coor_node = debug_coor_tscn.instantiate()
		debug_coor_node.direction = debug_coor_node.Direction.XN
		debug_coor_node.offset = Vector3i(-k,i,j)
		self.add_child(debug_coor_node)

		debug_coor_node = debug_coor_tscn.instantiate()
		debug_coor_node.direction = debug_coor_node.Direction.XP
		debug_coor_node.offset = Vector3i(k+4,i,j)
		self.add_child(debug_coor_node)

		debug_coor_node = debug_coor_tscn.instantiate()
		debug_coor_node.direction = debug_coor_node.Direction.YN
		debug_coor_node.offset = Vector3i(i,-k,j)
		self.add_child(debug_coor_node)

		debug_coor_node = debug_coor_tscn.instantiate()
		debug_coor_node.direction = debug_coor_node.Direction.YP
		debug_coor_node.offset = Vector3i(i,k+4,j)
		self.add_child(debug_coor_node)

		debug_coor_node = debug_coor_tscn.instantiate()
		debug_coor_node.direction = debug_coor_node.Direction.ZN
		debug_coor_node.offset = Vector3i(i,j,-k)
		self.add_child(debug_coor_node)

		debug_coor_node = debug_coor_tscn.instantiate()
		debug_coor_node.direction = debug_coor_node.Direction.ZP
		debug_coor_node.offset = Vector3i(i,j,k+4)
		self.add_child(debug_coor_node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var camera = get_viewport().get_camera_3d()
	camera_global_position_4i = (camera.global_position/4).floor()*4
