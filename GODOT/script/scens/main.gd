extends CanvasLayer
@onready var scenes = {"main": $Scen1, "settings": $Scen2, "del": $Del}
@onready var status_labels = {"on": $Scen1/Status/On, "off": $Scen1/Status/Off}
@onready var main_buttons = {"start": $Scen1/VBoxContainer/Start, "off": $Scen1/VBoxContainer/Quit}

var path_kill = OS.get_executable_path().get_base_dir() + "/data/bat/kill.bat"
var start_state = 0
var global_con = "18"

func read_file(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		global_con = file.get_as_text()
		return global_con
	else:
		return ""
func all_print():
	print(is_winws_running())
	print(global_con)
	print(get_window().size)
	print(scenes)
	print(status_labels)
	print(main_buttons)
	print(path_kill)
	print(OS.get_executable_path().get_base_dir())
	print(OS.get_executable_path().get_base_dir() + "/vers.txt")
	print(OS.get_executable_path().get_base_dir() + "/data/TRYN_PROXY.exe")
	print(OS.get_data_dir() + "/TrynDPI")
func _ready():
	var exe_path = (OS.get_executable_path().get_base_dir() + "/unins000.exe")
	if FileAccess.file_exists(exe_path):
		pass
	else:
		$Scen2/VBoxContainer/del.hide()
	read_file(OS.get_executable_path().get_base_dir() + "/vers.txt")
	get_window().borderless = false 
	get_window().size = Vector2i(780, 680)
	switch_scene("main")
	all_print()
	OS.low_processor_usage_mode = true
	$Vers.text = Global.vers
	main_buttons.start.pressed.connect(run_dpi)
	main_buttons.off.pressed.connect(stop_dpi)
	$Scen1/VBoxContainer/Restart.pressed.connect(restart_dpi)
	$Settings.pressed.connect(switch_scene.bind("settings"))
	$Status.pressed.connect(switch_scene.bind("main"))
	$Scen1/VBoxContainer/Proxy.pressed.connect(func():OS.shell_open(OS.get_executable_path().get_base_dir() + "/data/TRYN_PROXY.exe"))
	if is_winws_running() == true:
		$Scen1/VBoxContainer/Start.hide()
		$Scen1/VBoxContainer/Quit.show()
	if not global_con == Global.const_vers and Global.upavt == 0:
		Global.test = 1
		get_tree().change_scene_to_file("res://scenes/loading.tscn")
	else:
		OS.move_to_trash(OS.get_executable_path().get_base_dir() + "/data/updates/vers")
func switch_scene(key):
	for s in scenes.values(): s.hide()
	scenes[key].show()

func update_ui(is_running: bool):
	status_labels.on.visible = is_running
	status_labels.off.visible = !is_running
	main_buttons.off.visible = is_running
	main_buttons.start.visible = !is_running

func run_dpi():
	OS.shell_open(Global.path)
	update_ui(true)
	start_state = 1
	
func stop_dpi():
	OS.shell_open(path_kill)
	update_ui(false)
	start_state = 0

func restart_dpi():
	OS.shell_open(path_kill)
	update_ui(false)
	await get_tree().create_timer(1.5).timeout
	OS.shell_open(Global.path)
	update_ui(true)
	start_state = 1

func _process(_delta):
	if Global.start == 1:
		Global.start = 0
		run_dpi()

func is_winws_running() -> bool:
	var output = []
	OS.execute("tasklist", ["/NH", "/FI", "IMAGENAME eq winws.exe"], output, true)
	
	if output.size() > 0:
		return output[0].contains("winws.exe")
	return false
