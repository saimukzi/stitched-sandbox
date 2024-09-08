extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mesh:PlaneMesh = self.mesh
	var material:StandardMaterial3D = mesh.surface_get_material(0)
	
	#var image = BorderImage.create_image(16, Color.WHITE, Color.BLACK, 1)
	#var imageTexture = ImageTexture.create_from_image(image)
	
	material.albedo_texture = BorderImage.get_texture(16, Color.WHITE, Color.BLACK, 1)
	#mesh.surface_set_material(0, material)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
