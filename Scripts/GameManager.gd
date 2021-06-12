extends Node

enum STATES { GAME, MENU, IDLE }

var gameState = STATES.MENU

func _ready():
	OS.center_window()

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
