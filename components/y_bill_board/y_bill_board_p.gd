extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var parent = get_parent()
	if parent == null: return
	var camera = get_viewport().get_camera_3d()
	var camera_pos_g = camera.global_position
	var camera_pos_l = parent.to_local(camera_pos_g)
	var target_pos = camera_pos_l
	target_pos.y = 0
	if target_pos.length_squared() == 0: return
	target_pos = target_pos.normalized()
	var angle = Vector2(-target_pos.z, -target_pos.x).angle()
	parent.rotate_y(angle)
