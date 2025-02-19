extends Control

@onready var description: Node = $Description

func _ready() -> void:
	SignalHandler.connect("country_selected", Callable(self, "country_selected"))
	SignalHandler.connect("event_generated", Callable(self, "event_generated"))

func _on_option_1_pressed() -> void:
	SignalHandler.emit_signal("event_option_selected", 1)
	self.visible = false

func _on_option_2_pressed() -> void:
	SignalHandler.emit_signal("event_option_selected", 2)
	self.visible = false

func country_selected(_country: String, _flag: String, _population: int, _economy: int, _stability: int, _military: int, _cooperation: int) -> void:
	self.visible = false
	
func event_generated(event_description: String, country_1: String, country_2: String, option_1: String, option_2: String) -> void:
	var new_text: String = event_description.replace("COUNTRY1", country_1).replace("COUNTRY2", country_2)
	$Description.text = new_text
	var new_option_1: String = option_1.replace("COUNTRY1", country_1).replace("COUNTRY2", country_2)
	$Option1.text = new_option_1
	var new_option_2: String = option_2.replace("COUNTRY1", country_1).replace("COUNTRY2", country_2)
	$Option2.text = new_option_2
	self.visible = true
