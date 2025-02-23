extends Control

@onready var description: Node = $Description

var current_event: int = 1
var events_this_turn: int = 1

var total_turns: int = 0

@export var in_tutorial: bool = false

func _ready() -> void:
	SignalHandler.connect("country_selected", Callable(self, "country_selected"))
	SignalHandler.connect("event_generated", Callable(self, "event_generated"))
	SignalHandler.connect("new_turn", Callable(self, "new_turn"))
	SignalHandler.connect("game_started", Callable(self, "game_started"))
	SignalHandler.connect("set_event_info_visibility", Callable(self, "set_event_info_visibility"))
	SignalHandler.connect("game_ended", Callable(self, "game_ended"))
	$Option1.visible = false
	$Option2.visible = false
	self.visible = false

func _on_option_1_pressed() -> void:
	SignalHandler.emit_signal("event_option_selected", 1)
	option_selected()
	$OptionAudio.play()

func _on_option_2_pressed() -> void:
	if current_event > events_this_turn:
		SignalHandler.emit_signal("new_turn")
	else:
		SignalHandler.emit_signal("event_option_selected", 2)
		option_selected()
		$OptionAudio.play()
	
func game_started() -> void:
	SignalHandler.emit_signal("new_event_requested")
	$Event.text = "Event " + str(current_event) + " / " + str(events_this_turn)
	$Option1.visible = true
	$Option2.visible = true
	self.visible = true

func country_selected(_country: String, _flag: String, _population: int, _economy: int, _stability: int, _military: int, _cooperation: int, _statuses: String) -> void:
	self.visible = false
	
func event_generated(event_description: String, country_1: String, country_2: String, option_1: String, option_2: String) -> void:
	var new_text: String = event_description.replace("COUNTRY1", country_1).replace("COUNTRY2", country_2)
	#wtf but also this is a game jam so who cares
	var new_colored_text: String = new_text.replace("Satura", "[color=crimson]Satura[/color]").replace("Carateria", "[color=cyan]Carateria[/color]").replace("Canorland", "[color=lime]Canorland[/color]").replace("Leipand", "[color=orange]Leipand[/color]").replace("Lumeburg", "[color=lightslategray]Lumeburg[/color]").replace("Southern Isles", "[color=yellow]Southern Isles[/color]")
	$Description.text = new_colored_text
	var new_option_1: String = option_1.replace("COUNTRY1", country_1).replace("COUNTRY2", country_2)
	$Option1.text = new_option_1
	var new_option_2: String = option_2.replace("COUNTRY1", country_1).replace("COUNTRY2", country_2)
	$Option2.text = new_option_2
	$Option1.visible = true
	$Option2.visible = true
	self.visible = true

func new_turn() -> void:
	total_turns += 1
	self.visible = true
	$Option1.visible = true
	$Option2.visible = true
	events_this_turn = min(7, randi_range(1, 2 + (total_turns / 10)))
	current_event = 1
	$Event.text = "Event " + str(current_event) + " / " + str(events_this_turn)
	SignalHandler.emit_signal("new_event_requested")

func option_selected() -> void:
	current_event += 1
	if !in_tutorial:
		if current_event > events_this_turn:
			$Option1.visible = false
			$Option2.visible = true
			$Option2.text = "New Year"
			$Event.text = "Year Finished"
			$Description.text = "You have completed all events this year. Please press New Year to continue."
			SignalHandler.emit_signal("finished_all_events_this_turn")
		else:
			$Event.text = "Event " + str(current_event) + " / " + str(events_this_turn)
			SignalHandler.emit_signal("new_event_requested")
	else:
		SignalHandler.emit_signal("display_notice_info", true, "Event")
		self.visible = false

func set_event_info_visibility(status: bool) -> void:
	self.visible = status
	if current_event > events_this_turn:	
		$Option1.visible = false
		$Option2.visible = true
		$Option2.text = "New Year"
		$Description.text = "You have completed all events this year. Please press New Year to continue."

func game_ended() -> void:
	self.visible = false
