extends Control

var ind = 2
var un = (OS.get_executable_path().get_base_dir() + "/unins000.exe")
var path_kill = (OS.get_executable_path().get_base_dir() + "/data/bat/kill.bat")
var reg = (OS.get_executable_path().get_base_dir() + "/data/bat/reg_del.bat")
func _on_option_button_item_selected(index: int) -> void :
    if index == 0:
        ind = 0
        _on_yes_pressed()
    if index == 1:
        ind = 1
        _on_yes_pressed()
func _on_yes_pressed() -> void :
    if ind == 0:
        OS.shell_open(un)
        await get_tree().create_timer(0.5).timeout
        OS.shell_open(path_kill)
        get_tree().quit()
    if ind == 1:
        OS.shell_open(reg)
        OS.shell_open(un)
        OS.move_to_trash(OS.get_data_dir() + "/TrynDpi/save.save")
        await get_tree().create_timer(0.5).timeout
        OS.shell_open(path_kill)
        get_tree().quit()
