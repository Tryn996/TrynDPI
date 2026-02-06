extends Control

#onready
@onready var Scen1 = $"../Scen1"
@onready var Scen2 = $"."
@onready var Scen3 = $"../Scen3"
@onready var Scen4 = $"../Del"
#button
@onready var SBOn1 = $VBoxContainer/Auto_on
@onready var SBOff1 = $VBoxContainer/Auto_off
@onready var SBOn2 = $VBoxContainer/Windows_on
@onready var SBOff2 = $VBoxContainer/Windows_off
@onready var SBOn3 = $VBoxContainer/Auto_open_on
@onready var SBOff3 = $VBoxContainer/Auto_open_off
@onready var BDel = $VBoxContainer/del
@onready var BTreyon4 = $VBoxContainer/Trey_on
@onready var BTreyoff4 = $VBoxContainer/Trey_off
@onready var Full_Setting = $VBoxContainer/Full_settings
@onready var BLists = $VBoxContainer/Lists
#label
@onready var Vers = $"../Vers"
@onready var LOn = $"../Scen1/Status/On"
@onready var LOff = $"../Scen1/Status/Off"
#var
var path_kill = (OS.get_executable_path().get_base_dir() + "/data/bat/kill.bat")
var save_path = "user://save.save"
var path = Global.path

#func
func load_txt_file(file_path: String) -> String:
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var content = file.get_as_text() # Читает весь файл
		file.close() # Важно закрыть файл
		return content
	else:
		print("Файл не найден: " + file_path)
		return ""
func save_game():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(Global.setting_start)
	file.store_var(Global.setting_window)
	file.store_var(Global.avtoload)
	file.store_var(Global.trey)
func _ready():
	Console.print_line(Global.vers)
	print(Global.vers)
	Console.print_line(OS.get_data_dir())
	print(OS.get_data_dir())
	Console.print_line(OS.get_executable_path())
	print(OS.get_executable_path())
	var my_data = load_txt_file("user://logs/godot.log")
	Console.print_line(my_data)
	print(my_data)
	if not OS.is_debug_build():
		var file = FileAccess.open(OS.get_executable_path().get_base_dir() + "/data/lists/list-general.txt", FileAccess.READ)
		var content = file.get_as_text()
		Console.print_line(content)
		print(content)
		file.close()
	SBOn1.pressed.connect(func():
		Global.setting_start = 1
		SBOn1.hide()
		SBOff1.show()
		save_game())
	SBOff1.pressed.connect(func():
		Global.setting_start = 0
		SBOff1.hide()
		SBOn1.show()
		save_game())
	SBOn2.pressed.connect(func():
		Global.setting_window = 1
		SBOff2.show()
		SBOn2.hide()
		save_game())
	SBOff2.pressed.connect(func():
		SBOn2.show()
		SBOff2.hide()
		Global.setting_window = 0
		save_game())
	SBOn3.pressed.connect(func():
		Global.avtoload = 2
		SBOn3.hide()
		SBOff3.show()
		OS.shell_open(OS.get_executable_path().get_base_dir() + "/data/reg.bat")
		save_game())
	SBOff3.pressed.connect(func():
		Global.avtoload = 1
		SBOn3.show()
		SBOff3.hide()
		OS.shell_open(OS.get_executable_path().get_base_dir() + "/data/bat/reg_del.bat")
		save_game())
	BTreyoff4.pressed.connect(func():
		Global.trey = 0
		BTreyoff4.hide()
		BTreyon4.show()
		save_game())
	BTreyon4.pressed.connect(func():
		Global.trey = 1
		BTreyon4.hide()
		BTreyoff4.show()
		save_game())
	BDel.pressed.connect(func():
		Scen4.show()
		Scen3.hide()
		Scen2.hide()
		Scen1.hide())
	Full_Setting.pressed.connect(func():
		OS.shell_open(OS.get_executable_path().get_base_dir() + "/data/service.bat"))
	BLists.pressed.connect(func():
		OS.shell_open(OS.get_executable_path().get_base_dir() + "/data/lists/list-general.txt"))
	$VBoxContainer/Corn.pressed.connect(func():
		OS.shell_open(OS.get_executable_path().get_base_dir()))
func _process(float):
	Console.add_command("quit", func():
		save_game()
		get_tree().quit())
	Console.add_command("quit_kill", func():
		OS.shell_open(path_kill)
		save_game()
		get_tree().quit())
	Console.add_command("on", func():
		LOn.show()
		LOff.hide()
		OS.shell_open(path))
	Console.add_command("off", func():
		LOff.show()
		LOn.hide()
		OS.shell_open(path_kill))
	Console.add_command("help", func():
		Console.commands_list())
	Console.add_command("clear", Console.clear)
	Console.add_command("restart", func():
		OS.shell_open(path_kill)
		LOff.hide()
		LOn.show()
		await get_tree().create_timer(0.5).timeout
		LOff.hide()
		LOn.show()
		OS.shell_open(path))
	Console.add_command("del_set", func():
		OS.move_to_trash(OS.get_data_dir() + "/TrynDpi/setting.save"))
	if Global.trey == 0:
		get_tree().set_auto_accept_quit(false)
	if Global.trey == 1:
		get_tree().set_auto_accept_quit(true)
		
