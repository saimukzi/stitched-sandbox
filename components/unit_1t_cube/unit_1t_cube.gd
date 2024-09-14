extends Node3D

@export var material:Material
@export var rm_target:NodePath

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_mesh()
	var rm_target_node = self.get_node(rm_target)
	var col_obj_node = $unit_1t_cube/Cube/StaticBody3D
	var rm_target_path2 = col_obj_node.get_path_to(rm_target_node)
	col_obj_node.set_meta('rm_target', rm_target_path2)

func _update_mesh():
	if material == null: return
	var key = "Unit1tCute._update_mesh:%d"%[material.get_instance_id()]
	var mesh:ArrayMesh = G.get_weak(key)
	if mesh == null:
		mesh = $unit_1t_cube/Cube.mesh
		mesh = mesh.duplicate()
		mesh.surface_set_material(0, material)
		G.set_weak(key,mesh)
	$unit_1t_cube/Cube.mesh = mesh

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print('FIQZUPKNWK %d'%[$unit_1t_cube/Cube.mesh.get_instance_id()])
	pass
