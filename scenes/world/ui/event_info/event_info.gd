extends Control

@onready var description: Node = $Description

func _ready() -> void:
	SignalHandler.connect("country_selected", Callable(self, "country_selected"))

func _on_option_1_pressed() -> void:
	SignalHandler.emit_signal("event_option_selected", 1)

func _on_option_2_pressed() -> void:
	SignalHandler.emit_signal("event_option_selected", 2)

func country_selected(_country: String, _flag: String, _population: int, _economy: int, _stability: int, _military: int, _cooperation: int) -> void:
	self.visible = false
