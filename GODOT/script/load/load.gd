extends Node

@onready var BStart = $"../Scen1/VBoxContainer/Start"
@onready var BOff = $"../Scen1/VBoxContainer/Quit"
@onready var SBOn1 = $"../Scen2/VBoxContainer/Auto_on"
@onready var SBOff1 = $"../Scen2/VBoxContainer/Auto_off"
@onready var SBOn3 = $"../Scen2/VBoxContainer/Auto_open_on"
@onready var SBOff3 = $"../Scen2/VBoxContainer/Auto_open_off"
@onready var LOn = $"../Scen1/Status/On"
@onready var LOff = $"../Scen1/Status/Off"

var path_kill = (OS.get_executable_path().get_base_dir() + "/data/bat/kill.bat")
var save_path = "user://save.save"
var start = 0
var path = Global.path

func load_game():
	var file = FileAccess.open(save_path, FileAccess.READ)
	Global.setting_start = file.get_var(Global.setting_start)
	Global.avtoload = file.get_var(Global.avtoload)
	Global.transp = file.get_var(Global.transp)
	Global.upavt = file.get_var(Global.upavt)
func _ready():
	load_game()
	print(str("S",Global.setting_start,"A",Global.avtoload,"T",Global.transp,"U",Global.upavt))
	if Global.transp == 1:
		$"../Scen2/VBoxContainer/tra_on".hide()
		$"../Scen2/VBoxContainer/tra_off".show()
	if Global.transp == 0:
		$"../Scen2/VBoxContainer/tra_off".hide()
		$"../Scen2/VBoxContainer/tra_on".show()
	if Global.avtoload == 1:
		SBOff3.hide()
		SBOn3.show()
	if Global.avtoload == 2:
		SBOn3.hide()
		SBOff3.show()
	if Global.setting_start == 1:
		Global.setting_start = 0
		OS.shell_open(path)
		BStart.hide()
		BOff.show()
		LOff.hide()
		LOn.show()
		SBOn1.hide()
		SBOff1.show()
	if Global.upavt == 0:
		$"../Scen2/VBoxContainer/upavt_off".hide()
		$"../Scen2/VBoxContainer/upavt_on".show()
	if Global.upavt == 1:
		$"../Scen2/VBoxContainer/upavt_off".show()
		$"../Scen2/VBoxContainer/upavt_on".hide()
