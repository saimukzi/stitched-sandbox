extends Node3D

@export var root:NodePath
@onready var _root_node = get_node(root)

@export var new_cube:NodePath
@onready var _new_cube_node = get_node(new_cube)

@export var right_hand:NodePath
@onready var _right_hand_node = get_node(right_hand)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#var can_new_cube = false
#var new_cube_pos: Vector3
var trigger_up = true
func _physics_process(delta):
	if (G.xr_enabled and (not _right_hand_node.is_button_pressed("trigger_click")) and (not _right_hand_node.is_button_pressed("grip_click"))):
		trigger_up = true
	var is_colliding = $RayCast3D.is_colliding()
	$CollisionBall.visible = is_colliding
	if not is_colliding:
		#can_new_cube = false
		return
	var col_pos = $RayCast3D.get_collision_point()
	$CollisionBall.global_position = col_pos
	#var col_obj = $RayCast3D.get_collider()
	#can_new_cube = true
	if (G.xr_enabled and trigger_up and _right_hand_node.is_button_pressed("trigger_click")):
		trigger_up = false

		var col_nor = $RayCast3D.get_collision_normal()
		var col_pos_nor = col_pos + col_nor
		
		var col_pos_bg = G.block_group.to_local(col_pos)
		var col_pos_nor_bg = G.block_group.to_local(col_pos_nor)
		var col_nor_bg = (col_pos_nor_bg-col_pos_bg).normalized()
		var new_block_pos_bg = (col_pos_bg+col_nor_bg*0.5).floor()
		self.get_meta('player_node').add_block(new_block_pos_bg)

	if (G.xr_enabled and trigger_up and _right_hand_node.is_button_pressed("grip_click")):
		trigger_up = false
		var col_obj = $RayCast3D.get_collider()
		var rm_node_path = col_obj.get_meta('rm_target')
		if rm_node_path != null:
			var rm_obj = col_obj.get_node(rm_node_path)
			rm_obj.queue_free()
		
	
