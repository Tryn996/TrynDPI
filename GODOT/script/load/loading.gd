extends CanvasLayer

@onready var anim = $AnimationPlayer

func _ready() -> void:
	if Global.test == 1:
		updeate()
	if Global.test == 0:
		start()
	
func updeate():
	get_window().borderless = true
	get_window().size = Vector2i(450, 450)
	anim.play("new_updeate")
	OS.shell_open(OS.get_executable_path().get_base_dir() + "/data/updates/main.exe")
	await get_tree().create_timer(15).timeout
	get_tree().quit()

func start():
	OS.shell_open(OS.get_executable_path().get_base_dir() + "/data/updates/updeate.exe")
	await get_tree().create_timer(5).timeout
	get_tree().call_deferred("change_scene_to_file", "res://scenes/main.tscn")
