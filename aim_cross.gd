extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var win_size = DisplayServer.window_get_size()
	self.position = win_size/2
