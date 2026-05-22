extends CanvasLayer

@onready var anim = $AnimationPlayer
var save_path = "user://save.save"

func _ready() -> void:
	if OS.get_locale_language() == "ru":
		pass
	else:
		$Label.position = Vector2(170,316)
	if Global.test == 1:
		updeate()
	if Global.test == 0:
		start()
	
func updeate():
	OS.shell_open(OS.get_executable_path().get_base_dir() + "/data/bat/kill.bat")
	get_window().borderless = true
	get_window().size = Vector2i(450, 450)
	anim.play("new_updeate")
	OS.shell_open(OS.get_executable_path().get_base_dir() + "/data/updates/main.exe")
	await get_tree().create_timer(16).timeout
	get_tree().quit()

func start():
	load_game()
	if Global.transp == 1:
		get_window().transparent_bg = true
		get_viewport().transparent_bg = true
		$ColorRect.visible = true
		$"ColorRect2".visible = false
	if Global.transp == 0:
		get_window().transparent_bg = false
		get_viewport().transparent_bg = false
		$"ColorRect".visible = false
		$"ColorRect2".visible = true
	print(str("Setting_start: ",Global.setting_start," Avtoload: ",Global.avtoload," Transp: ",Global.transp," Upavt: ",Global.upavt))
	if Global.upavt == 0:
		OS.shell_open(OS.get_executable_path().get_base_dir() + "/data/updates/updeate.exe")
		await get_tree().create_timer(5).timeout
	get_tree().call_deferred("change_scene_to_file", "res://scenes/main.tscn")

func load_game():
	var file = FileAccess.open(save_path, FileAccess.READ)
	Global.setting_start = file.get_var(Global.setting_start)
	Global.avtoload = file.get_var(Global.avtoload)
	Global.transp = file.get_var(Global.transp)
	Global.upavt = file.get_var(Global.upavt)
