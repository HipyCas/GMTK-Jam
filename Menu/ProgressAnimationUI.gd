extends TextureProgress



func _on_TextureProgress_mouse_entered():
	$Tween.stop(self)
	$Tween.interpolate_property(self, 'value', value, 100, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()

func _on_TextureProgress_mouse_exited():
	$Tween.stop(self)
	$Tween.interpolate_property(self, 'value', value, 0, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()
