extends Node3D

@export var radius:float = 4
@export var y_avg:float = 0
@export var y_var:float = 1/G.PHI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera3D.radius = self.radius
	$Camera3D.y_avg = self.y_avg
	$Camera3D.y_var = self.y_var


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
