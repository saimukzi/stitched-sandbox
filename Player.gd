extends XROrigin3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	G.camera = $XRCamera3D
	MouseCapture.mouse_motion.connect(_on_mouse_motion)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# move
	var velocity = Vector3.ZERO
	if Input.is_action_pressed("move_front"):
		velocity.z -= 1
	if Input.is_action_pressed("move_back"):
		velocity.z += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	velocity = velocity.normalized()
	if G.xr_enabled:
		var p = $LeftHand.get_vector2("primary")
		velocity.x += p.x
		velocity.z -= p.y
	if velocity.length() > 1:
		velocity = velocity.normalized()
	velocity *= delta
	velocity = transform.basis * velocity
	position += velocity
	
	# rotate
	if G.xr_enabled:
		var rad = 0
		var p = $RightHand.get_vector2("primary")
		rad -= p.x * delta * PI/2
		rotate_y(rad)

func _on_mouse_motion(event: InputEventMouseMotion):
	var dx:float = event.relative.x
	var dy:float = event.relative.y
	
	rotate_y(-dx*PI/3/G.screen_size.x)
	
	var drx = -dy*PI/3/G.screen_size.x
	var now_rx = $XRCamera3D.rotation.x
	#print(drx,now_rx)
	if now_rx + drx > PI/2:
		drx = PI/2 - now_rx
	if now_rx + drx < -PI/2:
		drx = -PI/2 - now_rx
	$XRCamera3D.rotate_x(drx)

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
