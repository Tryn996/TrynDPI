extends CanvasLayer


func _ready() -> void:
	get_window().borderless = true
	OS.shell_open(OS.get_executable_path().get_base_dir() + "/updates/updeate.exe")
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_file("res://res/scenes/main.tscn")
