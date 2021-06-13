extends RichTextLabel

func _process(delta):
	text = get_text()
	
func get_text():
	var txt = "COLLECTED:\n"
	for item in Upgrades.collected.keys():
		txt += "- " + str(item) + ": " + str(Upgrades.collected[item]) + "\n"
	return txt
