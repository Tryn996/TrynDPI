extends TextureRect

func _ready():
	load_any_texture(OS.get_executable_path().get_base_dir() + "/data/back.png",OS.get_executable_path().get_base_dir() + "/data/back.jpg")
func load_any_texture(path: String,path2:String):
		var image = Image.load_from_file(path)
		var image2 = Image.load_from_file(path2)
		if image:
			texture = ImageTexture.create_from_image(image)
		else:
			if image2:
				texture = ImageTexture.create_from_image(image2)
			else:
				pass
