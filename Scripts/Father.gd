extends StaticBody2D

func _process(delta):
	if 'arms' in Upgrades.completed:
		if 'legs' in Upgrades.completed:
			if 'battery' in Upgrades.completed:
				$Sprite.texture = load('res://Sprites/padre bot 3 batería (completo).png')
			else:
				$Sprite.texture = load('res://Sprites/padre bot 3 piernas.png')
		else:
			$Sprite.texture = load('res://Sprites/padre bot 2 (brazos).png')
	else:
		$Sprite.texture = load('res://Sprites/padre bot 1.png')  # Shouldn't ever happen
