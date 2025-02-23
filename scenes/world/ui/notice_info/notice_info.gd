extends Control

@export var in_tutorial: bool = false

var tutorial_finished: bool = false

var tutorial_text: Array = [
	"Welcome to GAME_NAME!",
	"This tutorial will walk you through the basics of playing GAME_NAME.",
	"As the newly-appointed Peace Supervisor, your task is to bring peace to the continent.",
	"You must fill the Peace Progress bar to 100% in order to win.",
	"Otherwise, if the War Progress bar reaches 100%, the continent will plunge into war and you will lose.",
	"In order to fill the Peace Progress bar, you must manipulate each country's attributes.",
	"Click on a country to learn more about it!", #7
	"Each country has four attributes: Economy, Stability, Military, and Cooperation.",
	"You must balance all these attributes in order to ensure peace.",
	"Attribute values may be changed in one of two ways.",
	"The first option is by changing it directly through influence.",
	"Influence is a currency that allows you to either add or subtract an attribute's value.",
	"You will gain at least one influence per year. You can gain more influence per year by increasing certain attributes. However, influence is capped at 5.",
	"Try changing a country's attribute with your influence!", #14
	"The second option is through events.",
	"Events are randomly generated scenarios that can either add or subtract attributes from countries depending on your choices.",
	"Here is an example of an event. Try making a decision!", #17
	"", #18
	"Every year is composed of a random number of events.",
	"Completing all events in a year advances the year and gives you influence, and advances both Peace and War Progress based on your countries' attributes.",
	"Next, we will take a look at attributes and how it affects the game.",
	"The first attribute is economy.",
	"If a country's economy is 10, it helps to increase influence generated per year.",
	"Multiple countries' economies should be kept at 10 in order to generate more influence per year.",
	"This means an additional influence point if two countries are at 10 economy, and two additional points if five countries have 10 economy.",
	"However, when economy is 2 or less, a random attribute will be decreased per year.",
	"Next is stability. Stability negatively affects Peace Progress when it is at 3 or lower.",
	"Therefore, it is important to keep stability high when aiming for peace.",
	"Next is military. This is one of the most critical attributes, since it contributes to War Progress when its value is too high or too low.",
	"At the start of the game, War Progress is disabled. However, when a certain amount of countries reach critical values in military at the same time, war progression will be enabled for the rest of the game.",
	"War Progress cannot be reduced. Play wisely!",
	"Lastly, cooperation. Cooperation is the most important attribute to monitor when you are aiming for peace.",
	"If a country's cooperation is at 10 at the start of a new year, it will contribute to Peace Progress.",
	"However, when its cooperation reaches 0, it can no longer be modified again and the country's attributes will no longer be affected by influence.",
	"In order to beat the game, you must reach 100% in Peace Progress. Good luck!", #35
]

var current_tutorial_position: int = 0

func _ready() -> void:
	SignalHandler.connect("new_notice", Callable(self, "new_notice"))
	SignalHandler.connect("country_selected", Callable(self, "country_selected"))
	SignalHandler.connect("display_notice_info", Callable(self, "display_notice_info"))
	self.visible = false
	if in_tutorial:
		next_text()

func new_notice() -> void:
	self.visible = true

func _on_next_event_pressed() -> void:
	match current_tutorial_position:
		7:
			pass
		35:
			tutorial_finished = true
			$Click.play()
		_:
			next_text()
			$Click.play()
	if tutorial_finished:
		SignalHandler.emit_signal("transition_requested", true, "res://scenes/title_screen/title_screen.tscn")

func next_text() -> void:
	if current_tutorial_position < tutorial_text.size():
		$Description.text = tutorial_text[current_tutorial_position]
		current_tutorial_position += 1
		match current_tutorial_position:
			7:
				$NextEvent.visible = false
			14:
				SignalHandler.emit_signal("add_influence", 1)
				$NextEvent.visible = false
			18:
				SignalHandler.emit_signal("set_country_info_tutorial_status", false)
				SignalHandler.emit_signal("new_event_requested")
				self.visible = false
				$NextEvent.visible = false
			35:
				$NextEvent.text = "Finish Tutorial"
				$NextEvent.visible = true

func country_selected(_country: String, _flag: String, _population: int, _economy: int, _stability: int, _military: int, _cooperation: int, _statuses: String) -> void:
	self.visible = false

func display_notice_info(display_immediately: bool, source: String) -> void:
	if display_immediately:
		self.visible = true
	else:
		self.visible = false
	match current_tutorial_position:
		0:
			next_text()
		7:
			$NextEvent.visible = true
			current_tutorial_position += 1
			next_text()
		14:
			if source == "Economy" || source == "Military" || source == "Stability" || source == "Cooperation":
				$NextEvent.visible = true
				next_text()
		18:
			SignalHandler.emit_signal("set_country_info_tutorial_status", true)
			$NextEvent.visible = true
			next_text()
