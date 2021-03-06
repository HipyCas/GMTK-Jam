extends KinematicBody2D

export var speed = 30
export var friction = .9
export var flip = false # By default sprite looks to the left

var velocity = Vector2()

onready var stateMachine = $AnimationTree["parameters/playback"]

var is_on_father = false

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
	print(Upgrades.collected, " | ", Upgrades.crafted)
	if Input.is_key_pressed(KEY_H) && not('arms' in Upgrades.crafted):
		var err = Upgrades.craft('arms')
		if err == '': print('UPGRADED: arms (left ', Upgrades.collected, ')')
		else: push_warning("Can't upgrade, not enough components")
		print(err)
	elif Input.is_key_pressed(KEY_J) && not('legs' in Upgrades.crafted):
		var err = Upgrades.craft('legs')
		if err == '': print('UPGRADED: lesg (left ', Upgrades.collected, ')')
		else: push_warning("Can't upgrade, not enough components")
		print(err)
	elif Input.is_key_pressed(KEY_K) && not('battery' in Upgrades.crafted):
		var err = Upgrades.craft('battery')
		if err == '': print('UPGRADED: battery (left ', Upgrades.collected, ')')
		else: push_warning("Can't upgrade, not enough components")
		print(err)
	
	if is_on_father:
		if Input.is_key_pressed(KEY_Y):
			print(Upgrades.install('arms'))
		elif Input.is_key_pressed(KEY_U):
			print(Upgrades.install('legs'))
		elif Input.is_key_pressed(KEY_I):
			print(Upgrades.install('battery'))

func _on_Area2D_area_entered(area):
	$Pickup.play()
	if area.get_class() == 'Hole':
		queue_free()
		return
	if area.get_class() == 'Father':
		is_on_father = true
		return
	Upgrades.collect(area.get_class().to_lower())
	area.queue_free() # Destroy the collected item


func _on_Area2D_area_exited(area):
	if area.get_class() == 'Father':
		is_on_father = false
		return
