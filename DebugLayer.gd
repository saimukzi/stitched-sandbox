extends Node3D

const RADIUS:int = 8

const debug_unit_tscn = preload("res://DebugUnit.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in range(-RADIUS,RADIUS+1): for y in range(-RADIUS,RADIUS+1): for z in range(-RADIUS,RADIUS+1):
		var debug_unit_node = debug_unit_tscn.instantiate()
		debug_unit_node.position = Vector3(x,y,z)
		self.add_child(debug_unit_node)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
