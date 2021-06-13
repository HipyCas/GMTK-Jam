extends StaticBody2D

func _process(delta):
	if 'arms' in Upgrades.installed:
		if 'legs' in Upgrades.installed:
			if 'battery' in Upgrades.installed:
				$Sprite.texture = load('res://Sprites/padre bot 3 batería (completo).png')
			else:
				$Sprite.texture = load('res://Sprites/padre bot 3 piernas.png')
		else:
			$Sprite.texture = load('res://Sprites/padre bot 2 (brazos).png')
	else:
		$Sprite.texture = load('res://Sprites/padre bot 1.png')  # Shouldn't ever happen
