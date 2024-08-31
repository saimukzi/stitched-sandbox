extends MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
const VISIBLE_THRESHOLD = tan(PI/6)**2
func _process(delta: float) -> void:
	var camera = get_viewport().get_camera_3d()
	var camera_position = camera.global_position
	var camera_ray = -camera.global_basis.z
	var position_diff = self.global_position - camera_position
	position_diff = position_diff.normalized()
	var cross_product = camera_ray.cross(position_diff)
	var cross_len2 = cross_product.length_squared()
	self.visible = cross_len2 > VISIBLE_THRESHOLD
