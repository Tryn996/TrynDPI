extends Control


@onready var Scen1 = $Scen1
@onready var Scen2 = $Scen2
@onready var Scen3 = $Scen3
@onready var Scen4 = $Del

@onready var BStart = $Scen1 / VBoxContainer / Start
@onready var BOff = $Scen1 / VBoxContainer / Quit
@onready var BRestart = $Scen1 / VBoxContainer / Restart
@onready var BQuit = $Scen1 / VBoxContainer / QuitAll
@onready var SBOn1 = $Scen2 / VBoxContainer / Auto_on
@onready var SBOff1 = $Scen2 / VBoxContainer / Auto_off
@onready var SBOn3 = $Scen2 / VBoxContainer / Auto_open_on
@onready var SBOff3 = $Scen2 / VBoxContainer / Auto_open_off
@onready var BDel = $Scen2 / VBoxContainer / del
@onready var BSettings = $Settings
@onready var BSatus = $Status
@onready var BDiscord = $Scen1 / Check / Discord
@onready var BYouTube = $Scen1 / Check / YouTube
@onready var BSpeedTest = $SpeedTest
@onready var BTreyon4 = $Scen2 / VBoxContainer / Trey_on
@onready var BTreyoff4 = $Scen2 / VBoxContainer / Trey_off
@onready var Update = $Scen1 / Check / Updeate

@onready var Vers = $Vers
@onready var LOn = $Scen1 / Status / On
@onready var LOff = $Scen1 / Status / Off

var path_kill = (OS.get_executable_path().get_base_dir() + "/data/bat/kill.bat")
var save_path = "user://save.save"
var start = 0
var path = Global.path
var time = Time.get_date_dict_from_system()
var pathOs = OS.get_executable_path()
var language = OS.get_locale_language()
func task_bar():
	var si: StatusIndicator = StatusIndicator.new()
	si.icon = load("res://res/icons/ext256.png")
	si.tooltip = "TrynDPI"
	add_child(si)
	var menu: PopupMenu = PopupMenu.new()
	add_child(menu)
	menu.add_item("Показать окно", 3)
	menu.add_separator()
	menu.add_item("Включить", 1)
	menu.add_item("Выключить", 2)
	menu.add_item("Перезапустить", 5)
	menu.add_separator()
	menu.add_item("Выход", 4)
	si.menu = menu.get_path()
	menu.id_pressed.connect(menu_item_pressed)
func menu_item_pressed(id):
	match id:
		1:
			Global.start = 1
		2:
			OS.shell_open(path_kill)
			LOn.hide()
			LOff.show()
			BOff.hide()
			BStart.show()
			start = 0
		4:
			if start == 1 or 2:
				OS.shell_open(path_kill)
			LOn.hide()
			LOff.show()
			BOff.hide()
			BStart.show()
			await get_tree().create_timer(0.5).timeout
			get_tree().quit()
		3:
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_NO_FOCUS, false)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		5:
			OS.shell_open(path_kill)
			LOn.hide()
			LOff.show()
			await get_tree().create_timer(0.5).timeout
			LOff.hide()
			LOn.show()
			OS.shell_open(path)
func _ready():
	print(Global.path)
	print(language)
	Scen1.show()
	Scen2.hide()
	Scen3.hide()
	Scen4.hide()
	if "--bat" in OS.get_cmdline_args():
		OS.shell_open(path)
		await get_tree().create_timer(0.1).timeout
		get_tree().quit()
	else:
		pass
	task_bar()
	OS.low_processor_usage_mode = true
	Vers.text = Global.vers
	BStart.pressed.connect( func():
		Global.start = 1
		start = 1)
	BRestart.pressed.connect( func():
		OS.shell_open(path_kill)
		LOn.hide()
		LOff.show()
		await get_tree().create_timer(0.5).timeout
		LOff.hide()
		LOn.show()
		OS.shell_open(path)
		BStart.hide()
		BOff.show())
	BQuit.pressed.connect( func():
		LOn.hide()
		LOff.show()
		OS.shell_open(path_kill)
		await get_tree().create_timer(0.5).timeout
		get_tree().quit())
	BOff.pressed.connect( func():
		OS.shell_open(path_kill)
		LOn.hide()
		LOff.show()
		BOff.hide()
		BStart.show()
		start = 0)
	BSettings.pressed.connect( func():
		Scen1.hide()
		Scen2.show()
		Scen4.hide()
		Scen3.hide())
	BSatus.pressed.connect( func():
		Scen2.hide()
		Scen1.show()
		Scen4.hide()
		Scen3.hide())
	BSpeedTest.pressed.connect( func():
		Scen3.show()
		Scen2.hide()
		Scen1.hide()
		Scen4.hide())
	Update.pressed.connect( func():
		YouTube.check_website_status("https://www.youtube.com/")
		Discord.check_website_status("https://discord.com/"))
func _process(float):
	if Global.start == 1:
		Global.start = 0
		OS.shell_open(path)
		LOff.hide()
		LOn.show()
		BStart.hide()
		BOff.show()
		YouTube.check_website_status("https://www.youtube.com/")
		Discord.check_website_status("https://discord.com/")
	if Global.quit == 1:
		Global.quit = 0
	if Input.is_action_just_pressed("Obnov"):
		OS.shell_open(OS.get_executable_path().get_base_dir() + "/TrynDPI.exe")
		get_tree().quit()
	BYouTube.text = YouTube.printer
	BDiscord.text = Discord.printer
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_NO_FOCUS, true)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)
