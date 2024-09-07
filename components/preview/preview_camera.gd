extends Camera3D

@export var radius:float = 4
@export var y_avg:float = 0
@export var y_var:float = 1/G.PHI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#const RADIUS = 4
var xz_angle:float = 0
var y_angle:float = 0
func _process(delta: float) -> void:
	xz_angle += delta
	y_angle += delta/G.PHI
	if xz_angle > 2*PI:
		xz_angle -= 2*PI
	if y_angle > 2*PI:
		y_angle -= 2*PI
	
	var p = Vector3(cos(xz_angle),y_var*sin(y_angle)+y_avg,sin(xz_angle))
	p = self.radius * p.normalized()
	self.position = p
	self.look_at(Vector3.ZERO)
