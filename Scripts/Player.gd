extends KinematicBody2D

export var speed = 100
export var flip = false # By default sprite looks to the left
var collected = {
	'wrench': 0,
	'spring': 0
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var v = Vector2(0, 0) # Empty vector in case no movement
	
	if Input.is_action_pressed("ui_right"):
		v = Vector2(speed, 0)
		flip = true
	elif Input.is_action_pressed("ui_left"):
		v = Vector2(-speed, 0)
		flip = false
	if Input.is_action_pressed("ui_up"):
		v = Vector2(0, -speed)
	elif Input.is_action_pressed("ui_down"):
		v = Vector2(0, speed)
	
	move_and_slide(v)
	
	$Sprite.flip_h = flip # Flip robot to look in direction of movement


func _on_Area2D_area_entered(area):
	collected[area.get_class().to_lower()] += 1
	print(collected)
	area.queue_free()
