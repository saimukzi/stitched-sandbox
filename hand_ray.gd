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
		var new_cube_pos = (col_pos+col_nor*0.5).floor()
		#var nc = _new_cube_node.duplicate()
		var color = Color(randf(),randf(),randf())
		var nc = BasicBlock.create(color)
		nc.position = new_cube_pos
		get_node('/root/Main').add_child(nc)

	if (G.xr_enabled and trigger_up and _right_hand_node.is_button_pressed("grip_click")):
		trigger_up = false
		var col_obj = $RayCast3D.get_collider()
		var rm_node_path = col_obj.get_meta('rm_target')
		if rm_node_path != null:
			var rm_obj = col_obj.get_node(rm_node_path)
			rm_obj.queue_free()
		
	
