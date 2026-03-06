extends CanvasLayer


func _ready() -> void:
		OS.shell_open(OS.get_executable_path().get_base_dir() + "/updates/updeate.exe")
		await get_tree().create_timer(4).timeout
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	
