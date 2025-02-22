extends Control

func _ready() -> void:
	SignalHandler.connect("game_over", Callable(self, "game_over"))
	self.visible = false

func game_over(reason: String) -> void:
	self.visible = true
	match reason:
		"Broken Treaty":
			$Description.text = "A majority of the countries have backed out of the agreement.
	The treaty has failed, and tensions continue between the countries.
			The future of the continent is uncertain."
		"Nuclear Exchange":
			$Description.text = "A nuclear weapon state has launched their nukes as a first strike strategy due to their severely weakened military.
	The continent is devastated, leaving millions of people dead."
		"Peace":
			$Description.text = "Thanks to your efforts, the countries have decided to finally make peace!
	The future of the continent looks bright.
	Congratulations! Thank you for playing!"
		"War":
			$Description.text = "After years of unresolved issues, the continent has once again plunged into war.
	Maybe you can try again?"
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 1)
	SignalHandler.emit_signal("game_ended")

func _on_play_again_pressed() -> void:
	SignalHandler.emit_signal("transition_requested", true, "res://scenes/world/world.tscn")

func _on_back_to_title_pressed() -> void:
	SignalHandler.emit_signal("transition_requested", true, "res://scenes/title_screen/title_screen.tscn")
