extends HBoxContainer

onready var minus = $Minus
onready var plus = $Plus
onready var rect = $Rect

var minusTrigger = true
var plusTrigger = true
var value = 0

func _process(delta):
	if minus.pressed and minusTrigger:
		value = min(value + 0.25, 1)
		minusTrigger = false
	if plus.pressed and plusTrigger:
		value = max(value - 0.25, 0)
		plusTrigger = false
	
	rect.value = (1 - value) * 100
	
	if not minus.pressed:
		minusTrigger = true
	if not plus.pressed:
		plusTrigger = true
