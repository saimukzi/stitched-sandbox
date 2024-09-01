extends Node3D

enum Direction {XP,XN,ZP,ZN,YXP,YXN,YZP,YZN}
@export var direction:Direction
@export var offset: Vector3i

enum Axis {X,Y,Z}
var _axis:Axis

const DIRECTION_TO_AXIS_DICT = {
	Direction.XP:Axis.X,
	Direction.XN:Axis.X,
	Direction.ZP:Axis.Z,
	Direction.ZN:Axis.Z,
	Direction.YXP:Axis.Y,
	Direction.YXN:Axis.Y,
	Direction.YZP:Axis.Y,
	Direction.YZN:Axis.Y,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var c:Color
	if direction == Direction.XP:
		$Offset.position = Vector3(0.5,0,2)
		$Offset.rotate_y(PI*1.5)
		$Offset.rotate_x(PI)
		c = Color.RED
	if direction == Direction.XN:
		$Offset.position = Vector3(0.5,0,2)
		$Offset.rotate_y(PI*1.5)
		c = Color.RED
	if direction == Direction.ZP:
		$Offset.position = Vector3(2,0,0.5)
		$Offset.rotate_y(PI)
		$Offset.rotate_x(PI)
		c = Color.BLUE
	if direction == Direction.ZN:
		$Offset.position = Vector3(2,0,0.5)
		$Offset.rotate_y(PI)
		c = Color.BLUE
	if direction == Direction.YXP:
		$Offset.position = Vector3(0,0.5,2)
		$Offset.rotate_y(PI*1.5)
		$Offset.rotate_z(PI*0.5)
		c = Color.GREEN
	if direction == Direction.YXN:
		$Offset.position = Vector3(0,0.5,2)
		$Offset.rotate_y(PI*0.5)
		$Offset.rotate_z(PI*1.5)
		c = Color.GREEN
	if direction == Direction.YZP:
		$Offset.position = Vector3(2,0.5,0)
		$Offset.rotate_y(PI*1)
		$Offset.rotate_x(PI*1.5)
		c = Color.GREEN
	if direction == Direction.YZN:
		$Offset.position = Vector3(2,0.5,0)
		$Offset.rotate_y(PI*0)
		$Offset.rotate_x(PI*0.5)
		c = Color.GREEN
	$Offset/Label3D.modulate = Color.WHITE
	$Offset/Label3D.modulate.a = 0.25
	$Offset/Label3D.outline_modulate = c
	$Offset/Label3D.outline_modulate.a = 0.25
	self._axis = DIRECTION_TO_AXIS_DICT[direction]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#var position_i : Vector3i
var camera_global_position_4i : Vector3i = Vector3i.ONE
var v : int = 1
func _process(delta: float) -> void:
	var parent = get_parent()
	if  self.camera_global_position_4i != parent.camera_global_position_4i:
		self.camera_global_position_4i = parent.camera_global_position_4i
		var new_position_i:Vector3i = offset + parent.camera_global_position_4i
		var new_position = Vector3(new_position_i)
		#var axis = DIRECTION_TO_AXIS_DICT[direction]
		if self.position != new_position:
			self.position = new_position
			if (self._axis==Axis.X) or (direction == Direction.YXP) or (direction == Direction.YXN):
				self.visible = new_position_i.z % 8 == 0
			if (self._axis==Axis.Z) or (direction == Direction.YZP) or (direction == Direction.YZN):
				self.visible = new_position_i.x % 8 == 0
		#var d = (axis == Axis.Z) or (direction == Direction.YXP) or (direction == Direction.YXN)
		#var m8 = ((new_position.x+new_position.y+new_position.z) % 8 == 0)
		#self.visible = d == m8
		if not self.visible: return
		var new_v = new_position_i.x if self._axis == Axis.X else \
				new_position_i.y if self._axis == Axis.Y else \
				new_position_i.z if self._axis == Axis.Z else \
				0
		if self.v != new_v:
			self.v = new_v
			$Offset/Label3D.text = str(new_v)
