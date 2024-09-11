extends Object

class_name BorderImage

static func get_texture(size:int, bg_color:Color, border_color:Color, border_width:int) -> ImageTexture:
	var key = "BorderImage.get_material:%d,%s,%s,%d"%[size,bg_color.to_html(true),border_color.to_html(true),border_width]
	var ret = G.get_weak(key)
	if ret != null: return ret
	ret = create_texture(size,bg_color,border_color,border_width)
	G.set_weak(key,ret)
	return ret

static func create_texture(size:int, bg_color:Color, border_color:Color, border_width:int) -> ImageTexture:
	#print('SRHKQAHCTP create_texture')
	var image = create_image(size,bg_color,border_color,border_width)
	var imageTexture = ImageTexture.create_from_image(image)
	return imageTexture

static func create_image(size:int, bg_color:Color, border_color:Color, border_width:int) -> Image :
	var retImage = Image.create_empty(size, size, true, Image.FORMAT_RGB8)
	retImage.fill(border_color)
	retImage.fill_rect(Rect2i(border_width,border_width,size-border_width*2,size-border_width*2),bg_color)
	return retImage
