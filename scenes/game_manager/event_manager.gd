extends Node

var events: Array = []

func _ready() -> void:
	initialize_events()
	generate_new_event()

func initialize_events() -> void:
	var event_file: FileAccess = FileAccess.open("res://misc/event_spreadsheet.csv", FileAccess.READ)
	while !event_file.eof_reached():
		var event_rows: PackedStringArray = event_file.get_csv_line(",")
		events.append(event_rows)
	events.pop_front()
	event_file.close()

func generate_new_event() -> void:
	pass
