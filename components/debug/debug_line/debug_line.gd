extends Node3D

enum Axis {X,Y,Z}
@export var axis:Axis
@export var offset: Vector3i

static var axis_to_material_dict = {}

@onready var mesh_node = $MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if axis_to_material_dict.is_empty():
		var ori_material = mesh_node.get_active_material(0)
		var materiall
		materiall = ori_material.duplicate(true)
		materiall.albedo_color = Color.RED
		axis_to_material_dict[Axis.X] = materiall
		materiall = ori_material.duplicate(true)
		materiall.albedo_color = Color.GREEN
		axis_to_material_dict[Axis.Y] = materiall
		materiall = ori_material.duplicate(true)
		materiall.albedo_color = Color.BLUE
		axis_to_material_dict[Axis.Z] = materiall
	
	mesh_node.set_surface_override_material(0, axis_to_material_dict[axis])
	if axis == Axis.X:
		self.rotate_z(PI/2)
	if axis == Axis.Z:
		self.rotate_x(PI/2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var parent = get_parent()
	#self.position = Vector3(offset) + parent.camera_global_position_4i
	self.position = Vector3(offset) + G.camera_global_position_4i
