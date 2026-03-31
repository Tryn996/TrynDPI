extends Node

var start = 0
var path = Global.path

func _ready():
	if Global.transp == 1:
		$"../Scen2/VBoxContainer/tra_on".hide()
		$"../Scen2/VBoxContainer/tra_off".show()
	if Global.transp == 0:
		$"../Scen2/VBoxContainer/tra_off".hide()
		$"../Scen2/VBoxContainer/tra_on".show()
	if Global.avtoload == 1:
		$"../Scen2/VBoxContainer/Auto_open_off".hide()
		$"../Scen2/VBoxContainer/Auto_open_on".show()
	if Global.avtoload == 2:
		$"../Scen2/VBoxContainer/Auto_open_on".hide()
		$"../Scen2/VBoxContainer/Auto_open_off".show()
	if Global.setting_start == 1:
		Global.setting_start = 0
		OS.shell_open(path)
		$"../Scen1/VBoxContainer/Start".hide()
		$"../Scen1/VBoxContainer/Quit".show()
		$"../Scen1/Status/Off".hide()
		$"../Scen1/Status/On".show()
		$"../Scen2/VBoxContainer/Auto_on".hide()
		$"../Scen2/VBoxContainer/Auto_off".show()
	if Global.upavt == 0:
		$"../Scen2/VBoxContainer/upavt_off".hide()
		$"../Scen2/VBoxContainer/upavt_on".show()
	if Global.upavt == 1:
		$"../Scen2/VBoxContainer/upavt_off".show()
		$"../Scen2/VBoxContainer/upavt_on".hide()
