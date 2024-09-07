extends Node3D

@export var material:Material

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$unit_1t_cube/Cube.mesh.surface_set_material(0,material)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
