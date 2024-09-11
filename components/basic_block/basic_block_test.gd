extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var block = $BasicBlockFactory.get_instance().create(Color.GREEN)
	#add_child(block)
#
	#block = $BasicBlockFactory.get_instance().create(Color.BLUE_VIOLET)
	#block.position = Vector3(-1,-1,-1)
	#add_child(block)
	var block
	block = BasicBlock.create(Color.GREEN)
	block.position = Vector3(0,0,0)
	add_child(block)
	block.position = Vector3(0,-1,-1)
	block = BasicBlock.create(Color.GREEN)
	add_child(block)

	block = BasicBlock.create(Color.BLUE_VIOLET)
	block.position = Vector3(-1,0,-1)
	add_child(block)
	block = BasicBlock.create(Color.BLUE_VIOLET)
	block.position = Vector3(-1,-1,0)
	add_child(block)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
