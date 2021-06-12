extends KinematicBody2D

export var speed = 30
export var friction = .9
export var flip = false # By default sprite looks to the left

var collected = {}

var velocity = Vector2()

onready var upgrades = get_node("../Upgrades")
onready var stateMachine = $AnimationTree["parameters/playback"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationTree.active = true

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
		flip = true
		$Particles.position.x = -20
	if Input.is_action_pressed("ui_left"): # Change it by elif? Causes some issues with key preferences. If makes it so pressing the opposite stops
		velocity.x -= speed
		flip = false
		$Particles.position.x = 30
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed
	if Input.is_action_pressed("ui_down"):
		velocity.y += speed
	
	velocity *= friction
	if velocity.length() < speed / 3: velocity = Vector2()
	
	if velocity.length() < 3 * speed / 2:
		$Moving.playing = false
		$Particles.emitting = false 
		stateMachine.travel("Idle")
	else: 
		$Moving.playing = true
		$Particles.emitting = true 
		stateMachine.travel("Move")
	
	move_and_slide(velocity)
	
	$Sprite.flip_h = flip # Flip robot to look in direction of movement
	
func _input(event):
	if Input.is_key_pressed(KEY_H):
		var res = upgrades.upgrade('hook', collected)
		collected = res[0]
		if res[1] == '': print('UPGRADED: hook (left ', collected, ')')
		else: push_warning('Can\'t upgrade hook, not enough components')
		print(res[1])
	elif Input.is_key_pressed(KEY_R):
		var res = upgrades.upgrade('ramp', collected)
		collected = res[0]
		if res[1] == '': print('UPGRADED: ramp (left ', collected, ')')
		else: push_warning('Can\'t upgrade ramp, not enough components')
		print(res[1])

func _on_Area2D_area_entered(area):
	$Pickup.play()
	collected[area.get_class().to_lower()] += 1 # Increase whatever type is conllected
	print(collected)
	area.queue_free() # Destroy the collected item
	print("Hook (press H): ", upgrades.can_upgrade('hook', collected), "; Ramp (press R): ", upgrades.can_upgrade('ramp', collected))
