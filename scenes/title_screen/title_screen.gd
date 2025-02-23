extends Node2D

func _on_play_pressed() -> void:
	SignalHandler.emit_signal("transition_requested", true, "res://scenes/world/world.tscn")
	$Click.play()

func _on_tutorial_pressed() -> void:
	SignalHandler.emit_signal("transition_requested", true, "res://scenes/tutorial/tutorial.tscn")
	$Click.play()
	
func _on_credits_pressed() -> void:
	SignalHandler.emit_signal("transition_requested", true, "res://scenes/credits/credits.tscn")
	$Click.play()
