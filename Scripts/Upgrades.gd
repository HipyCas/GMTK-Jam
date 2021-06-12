extends Node2D

export var upgrades = {
	'hook': {
		'wrench': 1,
		'spring': 2
	},
	'propeller': {
		'wrench': 2
	},
	'arms': { # Shoudl be done first
		
	},
	'legs': { # Should be done second
		
	},
	'battery': { # Should be done third/last
		
	}
}

var completed = []
var collected = {}

func can_upgrade(upgrade: String, components: Dictionary):
	if upgrades.has(upgrade):
		for component in upgrades[upgrade].keys():
			if not components.has(component):
				push_warning('Missing required components')
				return false
			if upgrades[upgrade][component] > components[component]:
				push_warning('Not enough components')
				return false
	return true
	
func upgrade(upgrade: String) -> String:
	var err_msg = ''
	if can_upgrade(upgrade, collected):
		completed.append(upgrade)
		for component in upgrades[upgrade].keys():
			collected[component] -= upgrades[upgrade][component]
	else: err_msg = 'Cannot upgrade with the collected components'
	return err_msg
	
func collect(item: String):
	if not collected.has(item):
		collected[item] = 0
	collected[item] += 1 # Increase whatever type is conllected
