extends Control

@onready var Scen1 = $"../Scen1"
@onready var Scen4 = $"../Del"
@onready var container = $VBoxContainer

var base_dir = OS.get_executable_path().get_base_dir()
var save_path = "user://save.save"

func _ready():
	setup_console()
	setup_toggle($VBoxContainer/Auto_on, $VBoxContainer/Auto_off, "setting_start", 1, 0)
	setup_toggle($VBoxContainer/Windows_on, $VBoxContainer/Windows_off, "setting_window", 1, 0)
	setup_toggle($VBoxContainer/Auto_open_on, $VBoxContainer/Auto_open_off, "avtoload", 2, 1, "/data/reg.bat", "/data/bat/reg_del.bat")
	setup_toggle($VBoxContainer/Trey_on, $VBoxContainer/Trey_off, "trey", 1, 0)
	$VBoxContainer/del.pressed.connect(func(): for s in [Scen1, self, $"../Scen3"]: s.hide(); Scen4.show())
	$VBoxContainer/Full_settings.pressed.connect(func(): OS.shell_open(base_dir + "/data/service.bat"))
	$VBoxContainer/Lists.pressed.connect(func(): OS.shell_open(base_dir + "/data/lists/list-general.txt"))
	$VBoxContainer/Corn.pressed.connect(func(): OS.shell_open(base_dir))
func setup_toggle(btn_on, btn_off, global_var, val_on, val_off, bat_on = "", bat_off = ""):
	var update_ui = func():
		var is_on = Global.get(global_var) == val_on
		btn_on.visible = !is_on
		btn_off.visible = is_on
	btn_on.pressed.connect(func(): 
		Global.set(global_var, val_on)
		if bat_on: OS.shell_open(base_dir + bat_on)
		save_game(); update_ui.call())
	btn_off.pressed.connect(func(): 
		Global.set(global_var, val_off)
		if bat_off: OS.shell_open(base_dir + bat_off)
		save_game(); update_ui.call())
	update_ui.call()
	
func save_game():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	for val in [Global.setting_start, Global.setting_window, Global.avtoload, Global.trey]:
		file.store_var(val)
func setup_console():
	Console.add_command("quit", func(): save_game(); get_tree().quit())
	Console.add_command("on", func(): OS.shell_open(Global.path))
	Console.add_command("off", func(): OS.shell_open(base_dir + "/data/bat/kill.bat"))
	Console.add_command("clear", Console.clear)
	Console.add_command("del_set", func():OS.move_to_trash(OS.get_data_dir() + "/TrynDpi/setting.save"))
	Console.add_command("del", func():OS.shell_open(base_dir + "/unins000.exe"))
func _process(_delta):
	get_tree().set_auto_accept_quit(Global.trey == 1)
