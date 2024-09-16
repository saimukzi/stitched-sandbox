extends CharacterBody3D

@onready var _lefthand = $XROrigin3D/LeftHand
@onready var _righthand = $XROrigin3D/RightHand
@onready var _camera = $XROrigin3D/XRCamera3D

const JUMP_HEIGHT = 1.1
var _jump_vec : Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MouseCapture.mouse_motion.connect(_on_mouse_motion)

	var g:float = ProjectSettings.get_setting("physics/3d/default_gravity")
	var gv:Vector3 = ProjectSettings.get_setting("physics/3d/default_gravity_vector")
	
	_jump_vec = -((2*JUMP_HEIGHT*g)**0.5)*gv
	
	recursive_meta_player(self)

#const JUMP_VEC = Gravity.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# rotate
	if G.xr_enabled:
		var rad = 0
		var p = _righthand.get_vector2("primary")
		rad -= p.x * delta * PI/2
		rotate_y(rad)

	# move
	#var velocity = Vector3.ZERO
	var ori_y = velocity.y
	
	var velocity_ctrl = Vector3.ZERO
	if Input.is_action_pressed("move_front"):
		velocity_ctrl.z -= 1
	if Input.is_action_pressed("move_back"):
		velocity_ctrl.z += 1
	if Input.is_action_pressed("move_left"):
		velocity_ctrl.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity_ctrl.x += 1
	velocity_ctrl = velocity_ctrl.normalized()
	if G.xr_enabled:
		var p = _lefthand.get_vector2("primary")
		velocity_ctrl.x += p.x
		velocity_ctrl.z -= p.y
	if velocity_ctrl.length() > 1:
		velocity_ctrl = velocity_ctrl.normalized()
	velocity_ctrl = transform.basis * velocity_ctrl

	if self.is_on_floor() and ori_y <= 0:
		var jump = false
		jump = jump or Input.is_action_pressed("jump")
		jump = jump or (G.xr_enabled and _righthand.is_button_pressed("ax_button"))
		if jump: velocity_ctrl += _jump_vec
	
	velocity = velocity_ctrl + get_gravity()*delta + ori_y * Vector3.UP

	move_and_slide()

func _on_mouse_motion(event: InputEventMouseMotion):
	var dx:float = event.relative.x
	var dy:float = event.relative.y
	
	rotate_y(-dx*PI/3/G.screen_size.x)
	
	var drx = -dy*PI/3/G.screen_size.x
	var now_rx = _camera.rotation.x
	#print(drx,now_rx)
	if now_rx + drx > PI/2:
		drx = PI/2 - now_rx
	if now_rx + drx < -PI/2:
		drx = -PI/2 - now_rx
	_camera.rotate_x(drx)

#func _input(event: InputEvent) -> void:
	#if runtime.mouse_capture:
		#if event is InputEventMouseMotion:
			#var dx:float = event.relative.x
			#var dy:float = event.relative.y
			#
			#rotate_y(-dx*PI/3/runtime.screen_size.x)
			#
			#var drx = -dy*PI/3/runtime.screen_size.x
			#var now_rx = $XRCamera3D.rotation.x
			##print(drx,now_rx)
			#if now_rx + drx > PI/2:
				#drx = PI/2 - now_rx
			#if now_rx + drx < -PI/2:
				#drx = -PI/2 - now_rx
			#$XRCamera3D.rotate_x(drx)


func _on_safe_box_body_exited(body: Node3D) -> void:
	if body != self: return
	self.velocity = Vector3.ZERO
	self.position = Vector3(0,0.001,0)


func add_block(pos: Vector3):
	var color = Color(randf(),randf(),randf())
	var nc = BasicBlock.create(color)
	nc.position = pos
	G.block_group.add_child(nc)


func recursive_meta_player(node: Node):
	node.set_meta('player_node', self)
	for c in node.get_children():
		recursive_meta_player(c)
