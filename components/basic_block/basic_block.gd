extends Node3D

class_name BasicBlock

@export var color: Color:
	set(value):
		color = value
		_update_material()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_material()

func _update_material():
	var unit_1t_cube = get_node_or_null('Unit1tCube')
	if unit_1t_cube == null: return
	unit_1t_cube.material = _get_material(color)
	#var material:Material = $Unit1tCube.material
	#material = material.duplicate()
	#$Unit1tCube.material = material

	#var invColor:Color = Color(
		#1 if color.r < 0.5 else 0,
		#1 if color.g < 0.5 else 0,
		#1 if color.b < 0.5 else 0,
	#)
	#var borderColor = (color + invColor)/2
	#
	#material.albedo_texture = BorderImage.get_texture(16,color,borderColor,1)

static func _get_material(color:Color):
	var key = "BasicBlock._get_material:%s" % [color.to_html(true)]
	var ret = G.get_weak(key)
	if ret != null: return ret
	
	#var invColor:Color = Color(
		#0 if color.r < 0.5 else 1,
		#0 if color.g < 0.5 else 1,
		#0 if color.b < 0.5 else 1,
	#)
	#var color_mean = (color.r+color.g+color.b)/3
	#var tarColor = Color.WHITE if color_mean < 0.5 else Color.BLACK
	var tarColor = Color.WHITE if color.get_luminance() < 0.5 else Color.BLACK
	var borderColor = (color + tarColor)/2
	
	ret = StandardMaterial3D.new()
	ret.albedo_texture = BorderImage.get_texture(16,color,borderColor,1)
	ret.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST_WITH_MIPMAPS
	G.set_weak(key, ret)
	return ret

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print('MOIIFJSHVI %d'%[$Unit1tCube.material.get_instance_id()])
	pass

const TSCN_PATH = "res://components/basic_block/basic_block.tscn"
static func create(color: Color):
	if not G.d.has('BasicBlock.tscn'):
		G.d['BasicBlock.tscn'] = load(TSCN_PATH)
	var tscn = G.d['BasicBlock.tscn']
	var instance = tscn.instantiate()
	instance.color = color
	return instance
	
