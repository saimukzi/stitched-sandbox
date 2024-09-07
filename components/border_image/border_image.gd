extends Object

class_name BorderImage

static func create_image(size:int, bg_color:Color, border_color:Color, border_width:int) -> Image :
	var retImage = Image.create_empty(size, size, true, Image.FORMAT_RGB8)
	retImage.fill(border_color)
	retImage.fill_rect(Rect2i(border_width,border_width,size-border_width*2,size-border_width*2),bg_color)
	return retImage
