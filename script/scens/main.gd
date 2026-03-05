extends CanvasLayer
@onready var scenes = {"main": $Scen1, "settings": $Scen2, "speed": $Scen3, "del": $Del}
@onready var status_labels = {"on": $Scen1/Status/On, "off": $Scen1/Status/Off}
@onready var main_buttons = {"start": $Scen1/VBoxContainer/Start, "off": $Scen1/VBoxContainer/Quit}

var path_kill = OS.get_executable_path().get_base_dir() + "/data/bat/kill.bat"
var start_state = 0
var global_time = Time.get_datetime_dict_from_system()
var global_con = "12"
func read_file(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		global_con = file.get_as_text()
		print(global_con)
		return global_con
	else:
		print(FileAccess.get_open_error())
		return ""
func _ready():
	read_file(OS.get_executable_path().get_base_dir() + "/vers.txt")
	get_window().borderless = false
	var screen_size = str(DisplayServer.screen_get_size())
	get_window().size = Vector2i(720, 680)
	if screen_size == "(2560,1440)":
		var screen_size_x = DisplayServer.screen_get_size().x /2 -560
		var screen_size_y = DisplayServer.screen_get_size().y /2 -40
		get_window().size = Vector2i(screen_size_x,screen_size_y)
	if screen_size == "(1920, 1080)":
		var screen_size_x = DisplayServer.screen_get_size().x /1.8 -475
		var screen_size_y = DisplayServer.screen_get_size().y /1.8 -40
		get_window().size = Vector2i(screen_size_x,screen_size_y)
	switch_scene("main")
	OS.low_processor_usage_mode = true
	$Vers.text = Global.vers
	if "--bat" in OS.get_cmdline_args():
		run_dpi()
		get_tree().quit()
	main_buttons.start.pressed.connect(run_dpi)
	main_buttons.off.pressed.connect(stop_dpi)
	$Scen1/VBoxContainer/Restart.pressed.connect(restart_dpi)
	$Settings.pressed.connect(switch_scene.bind("settings"))
	$Status.pressed.connect(switch_scene.bind("main"))
	$SpeedTest.pressed.connect(switch_scene.bind("speed"))
	$Scen1/Check/Updeate.pressed.connect(check_web)
	if not global_con == Global.const_vers:
		OS.shell_open(OS.get_executable_path().get_base_dir() + "/updates/main.exe")
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
	check_web()

func stop_dpi():
	OS.shell_open(path_kill)
	update_ui(false)
	start_state = 0

func restart_dpi():
	stop_dpi()
	await get_tree().create_timer(0.5).timeout
	run_dpi()

func check_web():
	YouTube.check_website_status("https://www.youtube.com/")
	Discord.check_website_status("https://discord.com/")
	Telegram.check_website_status("https://telegram.org/")

func _process(_delta):
	if Global.start == 1:
		Global.start = 0
		run_dpi()
	$Scen1/Check/YouTube.text = YouTube.printer
	$Scen1/Check/Discord.text = Discord.printer
	$Scen1/Check/Telegram.text = Telegram.printer
	
func _on_option_button_item_selected(index: int) -> void:
	if index == 1:
		get_window().size = Vector2i(720, 680)
	if index == 2:
		get_window().size = Vector2i(360, 340)
	if index == 0:
		get_window().size = Vector2i(1440, 1360)
