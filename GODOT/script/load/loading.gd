extends CanvasLayer

var remix = 0 
var args = OS.get_cmdline_args()
func _ready() -> void:
		var random_number = randi_range(1, 50)
		print(random_number)
		if random_number == 11:
			$Renix.play()
			$AnimationPlayer.play("remix")
			remix = 16
		else:
			pass
		OS.shell_open(OS.get_executable_path().get_base_dir() + "/data/updates/updeate.exe")
		await get_tree().create_timer(5 + remix).timeout
		get_tree().change_scene_to_file("res://scenes/main.tscn")
