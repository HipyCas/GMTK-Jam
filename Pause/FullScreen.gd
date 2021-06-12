extends TextureButton

func _ready():
	if OS.is_window_fullscreen():
		print("heu")
		pressed = true

func _toggled(button_pressed):
	if button_pressed:
		OS.window_fullscreen = true
	else:
		OS.window_fullscreen = false

