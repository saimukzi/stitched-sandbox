extends Node3D

enum Direction {XP,XN,YP,YN,ZP,ZN}
@export var direction:Direction
@export var offset: Vector3i

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var c:Color
	if direction == Direction.XP:
		self.rotate_y(PI*1.5)
		c = Color.RED
	if direction == Direction.XN:
		self.rotate_y(PI*0.5)
		c = Color.RED
	if direction == Direction.YP:
		self.rotate_x(PI*0.5)
		c = Color.GREEN
	if direction == Direction.YN:
		self.rotate_x(PI*1.5)
		c = Color.GREEN
	if direction == Direction.ZP:
		self.rotate_y(PI)
		c = Color.BLUE
	if direction == Direction.ZN:
		c = Color.BLUE
	$Label3D.modulate = Color.WHITE
	$Label3D.modulate.a = 0.25
	$Label3D.outline_modulate = c
	$Label3D.outline_modulate.a = 0.25


# Called every frame. 'delta' is the elapsed time since the previous frame.
var position_i : Vector3i
func _process(delta: float) -> void:
	var parent = get_parent()
	var new_position = offset + parent.camera_global_position_4i
	if new_position != self.position_i:
		self.position = Vector3(new_position)
		self.position_i = new_position
		var v = new_position.x if direction == Direction.XP else \
				new_position.x if direction == Direction.XN else \
				new_position.y if direction == Direction.YP else \
				new_position.y if direction == Direction.YN else \
				new_position.z if direction == Direction.ZP else \
				new_position.z if direction == Direction.ZN else \
				0
		var t = str(v)
		$Label3D.text = t
