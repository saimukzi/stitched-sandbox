extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("add_block"):
		var is_colliding = $RayCast3D.is_colliding()
		if not is_colliding:
			return
		var col_pos = $RayCast3D.get_collision_point()
		var col_nor = $RayCast3D.get_collision_normal()
		var new_cube_pos = (col_pos+col_nor*0.5).floor()
		var nc = _get_full_block().duplicate()
		nc.position = new_cube_pos
		G.world_node.add_child(nc)

	if Input.is_action_just_pressed("remove_block"):
		var is_colliding = $RayCast3D.is_colliding()
		if not is_colliding:
			return
		var col_obj = $RayCast3D.get_collider()
		var rm_node_path = col_obj.get_meta('rm_target')
		if rm_node_path != null:
			var rm_obj = col_obj.get_node(rm_node_path)
			rm_obj.queue_free()

var _full_block
func _get_full_block():
	if _full_block == null:
		_full_block = G.world_node.get_node("BlockBank/FullBlock")
	return _full_block
