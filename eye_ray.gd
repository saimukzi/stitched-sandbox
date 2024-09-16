extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("add_block"):
		if G.block_group == null: return
		var is_colliding = $RayCast3D.is_colliding()
		if not is_colliding:
			return
		var col_pos = $RayCast3D.get_collision_point()
		var col_nor = $RayCast3D.get_collision_normal()
		var col_pos_nor = col_pos + col_nor
		
		var col_pos_bg = G.block_group.to_local(col_pos)
		var col_pos_nor_bg = G.block_group.to_local(col_pos_nor)
		var col_nor_bg = (col_pos_nor_bg-col_pos_bg).normalized()
		var new_block_pos_bg = (col_pos_bg+col_nor_bg*0.5).floor()
		self.get_meta('player_node').add_block(new_block_pos_bg)

	if Input.is_action_just_pressed("remove_block"):
		var is_colliding = $RayCast3D.is_colliding()
		if not is_colliding:
			return
		var col_obj = $RayCast3D.get_collider()
		var rm_node_path = col_obj.get_meta('rm_target')
		if rm_node_path != null:
			var rm_obj = col_obj.get_node(rm_node_path)
			rm_obj.queue_free()
