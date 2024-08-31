extends Node3D

var related_position:Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var camera = get_viewport().get_camera_3d()
	
	# position
	var camera_global_position_i = get_parent().camera_global_position_i
	self.global_position = camera_global_position_i + related_position
	
	# face angle
	if G.xr_enabled:
		look_at(camera.global_position, camera.global_basis.y)
	else:
		var neg_camera_direction = camera.global_basis.z
		var target = global_position + neg_camera_direction
		look_at(target, camera.global_basis.y)
