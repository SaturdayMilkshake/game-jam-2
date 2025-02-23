extends Node2D

func _on_back_to_title_pressed() -> void:
	SignalHandler.emit_signal("transition_requested", true, "res://scenes/title_screen/title_screen.tscn")
	$Click.play()
