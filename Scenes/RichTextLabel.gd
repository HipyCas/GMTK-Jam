extends RichTextLabel

func _ready():
	hide()

func _process(delta):
	if 'arms' in Upgrades.installed && 'legs' in Upgrades.installed && 'battery' in Upgrades.installed:
		show()
