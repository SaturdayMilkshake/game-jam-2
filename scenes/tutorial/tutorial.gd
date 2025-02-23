extends Node2D

func _ready() -> void:
	$LeftPanel/EventInfo.visible = false
	$LeftPanel/CountryInfo.visible = false
	$LeftPanel/NoticeInfo.visible = true
	$LeftPanel/NoticeInfo

func _on_back_to_title_pressed() -> void:
	SignalHandler.emit_signal("transition_requested", true, "res://scenes/title_screen/title_screen.tscn")
