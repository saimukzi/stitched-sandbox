extends Node3D

const sick_shield_tscn = preload("res://SickShield.tscn")

@export var rightHand : NodePath
var rightHandNode
var player: CharacterBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node("/root/Main/Player")
	
	rightHandNode = get_node(rightHand)

	var sick_shield_node
	const shield_scale = Vector3(1/8.0,1/8.0,1/8.0)
	for i in range(8): for j in range(8):
		var ii = (2*i-7)/8.0
		var jj = (2*j-7)/8.0
		var jj2 = (2*j+1)/8.0
		# -z front
		sick_shield_node = sick_shield_tscn.instantiate()
		sick_shield_node.scale = shield_scale
		sick_shield_node.position.x = ii
		sick_shield_node.position.y = jj2
		sick_shield_node.position.z = -1
		sick_shield_node.rotate_y(PI)
		self.add_child(sick_shield_node)

		# +z back
		sick_shield_node = sick_shield_tscn.instantiate()
		sick_shield_node.scale = shield_scale
		sick_shield_node.position.x = ii
		sick_shield_node.position.y = jj2
		sick_shield_node.position.z = 1
		self.add_child(sick_shield_node)

		# -x left
		sick_shield_node = sick_shield_tscn.instantiate()
		sick_shield_node.scale = shield_scale
		sick_shield_node.position.x = -1
		sick_shield_node.position.y = jj2
		sick_shield_node.position.z = ii
		sick_shield_node.rotate_y(PI*1.5)
		self.add_child(sick_shield_node)

		# +x right
		sick_shield_node = sick_shield_tscn.instantiate()
		sick_shield_node.scale = shield_scale
		sick_shield_node.position.x = 1
		sick_shield_node.position.y = jj2
		sick_shield_node.position.z = ii
		sick_shield_node.rotate_y(PI*0.5)
		self.add_child(sick_shield_node)

		# -j bottom
		sick_shield_node = sick_shield_tscn.instantiate()
		sick_shield_node.scale = shield_scale
		sick_shield_node.position.x = ii
		sick_shield_node.position.y = 0
		sick_shield_node.position.z = jj
		sick_shield_node.rotate_x(PI*0.5)
		self.add_child(sick_shield_node)

		# -j top
		sick_shield_node = sick_shield_tscn.instantiate()
		sick_shield_node.scale = shield_scale
		sick_shield_node.position.x = ii
		sick_shield_node.position.y = 2
		sick_shield_node.position.z = jj
		sick_shield_node.rotate_x(PI*1.5)
		self.add_child(sick_shield_node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# rotate
	if G.xr_enabled:
		var p = rightHandNode.get_vector2("primary").x
		self.visible = (p!=0) or (not player.is_on_floor())
	else:
		self.visible = false
		self.get_parent().remove_child(self)
