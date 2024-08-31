extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var line_dir = self.global_basis.x
	#var line_dir_n = line_dir.normalized()
	var camera = get_viewport().get_camera_3d()
	var camera_pos_g = camera.global_position
	var camera_pos_l = self.to_local(camera_pos_g)
	var target_pos = camera_pos_l
	target_pos.x = 0
	if target_pos.length_squared() == 0: return
	target_pos = target_pos.normalized()
	var angle = Vector2(target_pos.y, target_pos.z).angle()
	self.rotate_x(angle)
