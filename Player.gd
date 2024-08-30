extends XROrigin3D

var runtime = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var runtime = _get_runtime()
	if runtime == null: return

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
	if runtime.xr_enabled:
		var p = $LeftHand.get_vector2("primary")
		velocity.x += p.x
		velocity.z -= p.y
	if velocity.length() > 1:
		velocity = velocity.normalized()
	velocity *= delta
	velocity = transform.basis * velocity
	position += velocity
	
	# rotate
	var rad = 0
	if runtime.xr_enabled:
		var p = $RightHand.get_vector2("primary")
		rad -= p.x * delta * PI/2
	rotate_y(rad)

func _input(event: InputEvent) -> void:
	var runtime = _get_runtime()
	if runtime == null: return
	if runtime.mouse_capture:
		if event is InputEventMouseMotion:
			var dx:float = event.relative.x
			var dy:float = event.relative.y
			
			rotate_y(-dx*PI/3/runtime.screen_size.x)
			
			var drx = -dy*PI/3/runtime.screen_size.x
			var now_rx = $XRCamera3D.rotation.x
			#print(drx,now_rx)
			if now_rx + drx > PI/2:
				drx = PI/2 - now_rx
			if now_rx + drx < -PI/2:
				drx = -PI/2 - now_rx
			$XRCamera3D.rotate_x(drx)

func _get_runtime():
	if runtime == null:
		runtime = get_node("/root/Main/Runtime")
	return runtime
