extends Control

@onready var Scen1 = $"../Scen1"
@onready var Scen4 = $"../Del"
@onready var container = $VBoxContainer

var base_dir = OS.get_executable_path().get_base_dir()
var save_path = "user://save.save"

func _ready():
	setup_toggle($VBoxContainer/Auto_on, $VBoxContainer/Auto_off, "setting_start", 1, 0)
	setup_toggle($VBoxContainer/Auto_open_on, $VBoxContainer/Auto_open_off, "avtoload", 2, 1, "/data/reg.bat", "/data/bat/reg_del.bat")
	setup_toggle($VBoxContainer/upavt_on,$VBoxContainer/upavt_off,"upavt",1,0)
	setup_toggle($VBoxContainer/tra_on,$VBoxContainer/tra_off,"transp",1,0)
	$VBoxContainer/del.pressed.connect(func(): 
		$".".hide()
		$"../Del".show())
	$VBoxContainer/Lists.pressed.connect(func(): OS.shell_open(base_dir + "/data/lists/list-general.txt"))
	$VBoxContainer/Corn.pressed.connect(func(): OS.shell_open(base_dir))
	$VBoxContainer/Bat.pressed.connect(func():OS.shell_open(OS.get_data_dir() + "/TrynDPI"))
	$VBoxContainer/del_up.pressed.connect(func():OS.move_to_trash(base_dir + "/data/updates/vers"))

func setup_toggle(btn_on, btn_off, global_var, val_on, val_off, bat_on = "", bat_off = ""):
	var update_ui = func():
		var is_on = Global.get(global_var) == val_on
		btn_on.visible = !is_on
		btn_off.visible = is_on
	btn_on.pressed.connect(func(): 
		Global.set(global_var, val_on)
		if bat_on: OS.shell_open(base_dir + bat_on)
		save(); update_ui.call())
	btn_off.pressed.connect(func(): 
		Global.set(global_var, val_off)
		if bat_off: OS.shell_open(base_dir + bat_off)
		save(); update_ui.call())
	update_ui.call()
func save():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	for val in [Global.setting_start, Global.avtoload,Global.transp,Global.upavt]:
		file.store_var(val)
func  _process(delta: float) -> void:
	if Global.transp == 1:
		get_window().transparent_bg = true
		get_viewport().transparent_bg = true
		$"../ColorRect".visible = true
		$"../ColorRect2".visible = false
	if Global.transp == 0:
		get_window().transparent_bg = false
		get_viewport().transparent_bg = false
		$"../ColorRect".visible = false
		$"../ColorRect2".visible = true
