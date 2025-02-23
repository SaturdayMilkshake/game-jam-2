extends Control

var tutorial_text: Array = [
	"Welcome to GAME_NAME!",
	"This tutorial will walk you through the basics of playing GAME_NAME.",
	"As the newly-appointed Peace Supervisor, your task is to bring peace to the continent.",
	"You must fill the Peace Progress bar to 100% in order to win.",
	"Otherwise, if the War Progress bar reaches 100%, the continent will plunge into war and you will lose.",
	"In order to fill the Peace Progress bar, you must manipulate each country's attributes.", #5
	"Click on a country to learn more about it!",
	""
]

var current_tutorial_position: int = 0

func _ready() -> void:
	SignalHandler.connect("new_notice", Callable(self, "new_notice"))
	SignalHandler.connect("country_selected", Callable(self, "country_selected"))
	SignalHandler.connect("display_notice_info", Callable(self, "display_notice_info"))
	self.visible = false
	next_text()

func new_notice() -> void:
	self.visible = true

func _on_next_event_pressed() -> void:
	match current_tutorial_position:
		7:
			pass
		_:
			next_text()

func next_text() -> void:
	self.visible = true
	if current_tutorial_position < tutorial_text.size():
		$Description.text = tutorial_text[current_tutorial_position]
		current_tutorial_position += 1
		match current_tutorial_position:
			7:
				$NextEvent.visible = false

func country_selected(_country: String, _flag: String, _population: int, _economy: int, _stability: int, _military: int, _cooperation: int, _statuses: String) -> void:
	self.visible = false

func display_notice_info() -> void:
	self.visible = true
	match current_tutorial_position:
		7:
			current_tutorial_position += 1
			next_text()
