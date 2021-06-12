extends TextureButton

func _toggled(button_pressed):
	if button_pressed:
		OS.window_fullscreen = true
	else:
		OS.window_fullscreen = false
