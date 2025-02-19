extends Button

var audio_enabled: bool = true

func _on_pressed() -> void:
	if audio_enabled:
		self.text = "O"
		audio_enabled = false
	else:
		self.text = "M"
		audio_enabled = true
