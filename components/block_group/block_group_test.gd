extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print('block_group found: ',G.block_group!=null)
	G.block_group.add_child(BasicBlock.create(Color.WHITE))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
