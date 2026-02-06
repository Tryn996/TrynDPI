extends Node


#button
@onready var BStart = $"../Scen1/VBoxContainer/Start"
@onready var BOff = $"../Scen1/VBoxContainer/Quit"
@onready var BRestart = $"../Scen1/VBoxContainer/Restart"
@onready var BQuit = $"../Scen1/VBoxContainer/QuitAll"
@onready var SBOn1 = $"../Scen2/VBoxContainer/Auto_on"
@onready var SBOff1 = $"../Scen2/VBoxContainer/Auto_off"
@onready var SBOn2 = $"../Scen2/VBoxContainer/Windows_on"
@onready var SBOff2 = $"../Scen2/VBoxContainer/Windows_off"
@onready var SBOn3 = $"../Scen2/VBoxContainer/Auto_open_on"
@onready var SBOff3 = $"../Scen2/VBoxContainer/Auto_open_off"
@onready var BDel = $"../Scen2/VBoxContainer/del"
@onready var BSettings = $"../Settings"
@onready var BSatus = $"../Status"
@onready var BDiscord = $"../Scen1/Check/Discord"
@onready var BYouTube = $"../Scen1/Check/YouTube"
@onready var BSpeedTest = $"../SpeedTest"
@onready var BTreyon4 = $"../Scen2/VBoxContainer/Trey_on"
@onready var BTreyoff4 = $"../Scen2/VBoxContainer/Trey_off"
#label
@onready var Vers = $"../Vers"
@onready var LOn = $"../Scen1/Status/On"
@onready var LOff = $"../Scen1/Status/Off"

var path_kill = (OS.get_executable_path().get_base_dir() + "/data/bat/kill.bat")
var save_path = "user://save.save"
var start = 0
var path = Global.path

func load_game():
	var file = FileAccess.open(save_path, FileAccess.READ)
	Global.setting_start = file.get_var(Global.setting_start)
	Global.setting_window = file.get_var(Global.setting_window)
	Global.avtoload = file.get_var(Global.avtoload)
	Global.trey = file.get_var(Global.trey)
func _ready() -> void:
	load_game()
	if Global.avtoload == 1:
		SBOff3.hide()
		SBOn3.show()
	if Global.avtoload == 2:
		SBOn3.hide()
		SBOff3.show()
	if Global.setting_window == 1:
		Global.setting_window = 0
		SBOn2.hide()
		SBOff2.show()
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_NO_FOCUS, true)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)
	if Global.setting_start == 1:
		Global.setting_start = 0
		OS.shell_open(path)
		BStart.hide()
		BOff.show()
		LOff.hide()
		LOn.show()
		SBOn1.hide()
		SBOff1.show()
	if Global.trey == 1:
		BTreyon4.hide()
		BTreyoff4.show()
	if Global.trey == 0:
		BTreyoff4.hide()
		BTreyon4.show()
