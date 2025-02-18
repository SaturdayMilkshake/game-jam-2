extends Node

@export var countries: Array[String] = [""]

var events: Array = []

var current_event: Array = []

func _ready() -> void:
	SignalHandler.connect("event_option_selected", Callable(self, "event_option_selected"))
	initialize_events()
	generate_new_event()

func initialize_events() -> void:
	var event_file: FileAccess = FileAccess.open("res://misc/event_spreadsheet.csv", FileAccess.READ)
	while !event_file.eof_reached():
		var event_rows: PackedStringArray = event_file.get_csv_line(",")
		events.append(event_rows)
	events.pop_front()
	events.pop_back()
	event_file.close()

func generate_new_event() -> void:
	var event_id: int = randi_range(0, events.size() - 1)
	current_event = events[event_id]
	SignalHandler.emit_signal("event_generated", current_event[1], current_event[2], current_event[3], current_event[4], current_event[5])

func event_option_selected(option: int) -> void:
	match option:
		1:
			print("1")
		2:
			print("2")
