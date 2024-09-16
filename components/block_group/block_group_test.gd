extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BlockGroup.add_child(BasicBlock.create(Color.WHITE))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
