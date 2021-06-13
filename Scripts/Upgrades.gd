extends Node2D

export var upgrades = {
	'arms': { # Shoudl be done first
		'bearing': 1,
		'nut': 2,
		'screw': 1
	},
	'legs': { # Should be done second
		'spring': 2,
		'wrench': 1,
		'screw': 1
	},
	'battery': { # Should be done third/last
		'bearing': 1,
		'spring': 1,
		'wrench': 1,
		'nut': 1
	}
}

var crafted = []
var collected = {}
var installed = []

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
	
func craft(upgrade: String) -> String:
	"""
	Craft a new item
	"""
	var err_msg = ''
	if not upgrades.has(upgrade):
		err_msg = 'The passed upgrade does not exist'
		return err_msg
	if can_upgrade(upgrade, collected):
		crafted.append(upgrade)
		for component in upgrades[upgrade].keys():
			collected[component] -= upgrades[upgrade][component]
	else: err_msg = 'Cannot upgrade with the collected components'
	return err_msg
	
func collect(item: String):
	if not collected.has(item):
		collected[item] = 0
	collected[item] += 1 # Increase whatever type is conllected
	
func install(item: String) -> String:
	if not upgrades.has(item):
		return "The passed upgrade does not exist"
	if item == 'arms' && 'arms' in crafted && not('arms' in installed):
		pass
	elif item == 'legs' && 'legs' in crafted && 'arms' in installed && not('legs' in installed):
		pass
	elif item == 'battery' && 'battery' in crafted && 'arms' in installed && 'legs' in installed && not('battery' in installed):
		pass
	else:
		return 'Cannot install'
	installed.append(item)
	remove(crafted, item)
	return ''

func remove(arr, item: String):
	for i in range(len(arr)):
		if arr[i] == item:
			arr.remove(i)
			return
