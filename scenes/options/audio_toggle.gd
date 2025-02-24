extends Button

var audio_enabled: bool = true

var audio_bus: int = AudioServer.get_bus_index("Master")

func _on_pressed() -> void:
	if audio_enabled:
		self.text = "O"
		audio_enabled = false
		AudioServer.set_bus_mute(audio_bus, true)
	else:
		self.text = "M"
		audio_enabled = true
		AudioServer.set_bus_mute(audio_bus, false)
		$Click.play()
