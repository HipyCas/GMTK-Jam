extends RichTextLabel

func _process(delta):
	text = get_text()
	
func get_text():
	var txt = "CRAFTED:\n"
	for item in Upgrades.crafted:
		txt += "- " + item + "\n"
	return txt
