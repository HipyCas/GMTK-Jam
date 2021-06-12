extends CanvasLayer

var pauseTrigger = false
var menuTrigger = true
var settings = []
var menuSettings = []

func _ready():
	$Control.visible = false
	for child in get_node("Control/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/Settings").get_children():
		settings.append(child)
	

func _process(delta):
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), settings[0].value * settings[0].value * -60 - 5)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), settings[1].value * settings[1].value * -60 - 5)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), settings[2].value * settings[2].value * -60 - 5)
	
	
	if Input.is_action_just_pressed("pause"):
		if not pauseTrigger:
			$Control.visible = true
			get_tree().paused = true
			pauseTrigger = true
		else:
			$Control.visible = false
			get_tree().paused = false
			pauseTrigger = false
	

