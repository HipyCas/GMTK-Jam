extends CanvasLayer

var clicked = true

onready var main = get_node("Control/MarginContainer/VBoxContainer/MainOptions")
onready var settings = get_node("Control/MarginContainer/VBoxContainer/Settings")
onready var canClick = get_node("CanClick")

func _ready():
	GameManager.gameState = GameManager.STATES.MENU
	for child in get_node("Control/MarginContainer/VBoxContainer/Settings/HBoxContainer/Settings").get_children():
		if child is MarginContainer:
			continue
		Pause.menuSettings.append(child)

func _on_Start_pressed():
	if clicked:
		clicked = false
		GameManager.gameState = GameManager.STATES.GAME
		get_tree().change_scene("res://Scenes/Test.tscn")
#		Transition.transition("res://Prefabs/LevelTemplate.tscn")

func _on_Options_pressed():
	changeMenus(false)

func _on_Exit_pressed():
	get_tree().quit()

func _on_Back_pressed():
	changeMenus(true)

func changeMenus(mainBool):
	main.visible = mainBool
	settings.visible = not mainBool

