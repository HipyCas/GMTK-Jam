extends KinematicBody2D

export var speed = 100
export var flip = false # By default sprite looks to the left
var collected = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var v = Vector2(0, 0) # Empty vector in case no movement
	
	if Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D):
		v.x += speed
		flip = true
	if Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A): # Change it by elif? Causes some issues with key preferences. If makes it so pressing the opposite stops
		v.x -= speed
		flip = false
	if Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W):
		v.y -= speed
	if Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S):
		v.y += speed
	
	move_and_slide(v)
	
	$Sprite.flip_h = flip # Flip robot to look in direction of movement
	
func _input(event):
	if Input.is_key_pressed(KEY_H):
		var res = Upgrades.upgrade('hook', collected)
		collected = res[0]
		if res[1] == '': print('UPGRADED: hook (left ', collected, ')')
		else: push_warning('Can\'t upgrade, not enough components')
		print(res[1])
	elif Input.is_key_pressed(KEY_R):
		var res = Upgrades.upgrade('ramp', collected)
		collected = res[0]
		if res[1] == '': print('UPGRADED: ramp (left ', collected, ')')
		else: push_warning('Can\'t upgrade ramp, not enough components')
		print(res[1])

func _on_Area2D_area_entered(area):
	if area.get_class() == 'Hole':
		print("Fell into hole!")
		return
	if not collected.has(area.get_class().to_lower()):
		collected[area.get_class().to_lower()] = 0
	collected[area.get_class().to_lower()] += 1 # Increase whatever type is conllected
	print(collected)
	area.queue_free() # Destroy the collected item
	print("Hook (press H): ", Upgrades.can_upgrade('hook', collected), "; Ramp (press R): ", Upgrades.can_upgrade('ramp', collected))
