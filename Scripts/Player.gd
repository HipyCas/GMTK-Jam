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
		v.x += speed
		flip = true
	elif Input.is_action_pressed("ui_left"):
		v.x -= speed
		flip = false
	if Input.is_action_pressed("ui_up"):
		v.y -= speed
	elif Input.is_action_pressed("ui_down"):
		v.y += speed
	
	move_and_slide(v)
	
	$Sprite.flip_h = flip # Flip robot to look in direction of movement


func _on_Area2D_area_entered(area):
	collected[area.get_class().to_lower()] += 1
	print(collected)
	area.queue_free()
