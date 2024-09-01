extends Node3D

const debug_coor_tscn = preload("res://debug_coor.tscn")

var camera_global_position_4i:Vector3i

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var debug_coor_node
	for i in range(-8,16,4): for j in range(0,8,4): for k in range(-8,12,4):
		debug_coor_node = debug_coor_tscn.instantiate()
		debug_coor_node.direction = debug_coor_node.Direction.XN
		debug_coor_node.offset = Vector3i(i,-j,k)
		self.add_child(debug_coor_node)

		debug_coor_node = debug_coor_tscn.instantiate()
		debug_coor_node.direction = debug_coor_node.Direction.XP
		debug_coor_node.offset = Vector3i(i,j+4,k)
		self.add_child(debug_coor_node)

		debug_coor_node = debug_coor_tscn.instantiate()
		debug_coor_node.direction = debug_coor_node.Direction.ZN
		debug_coor_node.offset = Vector3i(k,-j,i)
		self.add_child(debug_coor_node)

		debug_coor_node = debug_coor_tscn.instantiate()
		debug_coor_node.direction = debug_coor_node.Direction.ZP
		debug_coor_node.offset = Vector3i(k,j+4,i)
		self.add_child(debug_coor_node)

	for i in range(-8,12,4): for y in range(-8,16,4):
		debug_coor_node = debug_coor_tscn.instantiate()
		debug_coor_node.direction = debug_coor_node.Direction.YXP
		debug_coor_node.offset = Vector3i(12, y, i)
		self.add_child(debug_coor_node)

		debug_coor_node = debug_coor_tscn.instantiate()
		debug_coor_node.direction = debug_coor_node.Direction.YXN
		debug_coor_node.offset = Vector3i(-8, y, i)
		self.add_child(debug_coor_node)

		debug_coor_node = debug_coor_tscn.instantiate()
		debug_coor_node.direction = debug_coor_node.Direction.YZP
		debug_coor_node.offset = Vector3i(i, y, 12)
		self.add_child(debug_coor_node)

		debug_coor_node = debug_coor_tscn.instantiate()
		debug_coor_node.direction = debug_coor_node.Direction.YZN
		debug_coor_node.offset = Vector3i(i, y, -8)
		self.add_child(debug_coor_node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var camera = get_viewport().get_camera_3d()
	camera_global_position_4i = (camera.global_position/4).floor()*4
