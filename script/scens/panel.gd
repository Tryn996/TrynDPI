extends Panel

var dragging = false
var click_position = Vector2i()

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragging = true
				# Запоминаем позицию мыши относительно ГЛОБАЛЬНОГО экрана
				click_position = DisplayServer.mouse_get_position() - get_window().position
			else:
				dragging = false

	if event is InputEventMouseMotion and dragging:
		# Вычисляем новую позицию окна: текущая позиция мыши на экране МИНУС смещение клика
		get_window().position = DisplayServer.mouse_get_position() - click_position
