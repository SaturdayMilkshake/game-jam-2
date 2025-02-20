extends Node

var countries: Array[String] = ["Satura", "Carateria", "Arcasia", "Contana", "Beorland", "Southern Isles"]

var events: Array = []

var current_event: Array = []

func _ready() -> void:
	SignalHandler.connect("event_option_selected", Callable(self, "event_option_selected"))
	SignalHandler.connect("new_event_requested", Callable(self, "new_event_requested"))
	initialize_events()

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
	if current_event[2] == "RANDOM":
		current_event[2] = countries.pick_random()
	if current_event[3] == "RANDOM":
		current_event[3] = countries.pick_random()
		while current_event[3] == current_event[2]:
			current_event[3] = countries.pick_random()
	SignalHandler.emit_signal("event_generated", current_event[1], current_event[2], current_event[3], current_event[4], current_event[5])

func event_option_selected(option: int) -> void:
	if current_event:
		match option:
			1:
				SignalHandler.emit_signal("modify_country_value", current_event[2], current_event[6], current_event[7].to_int())
				SignalHandler.emit_signal("modify_country_value", current_event[2], current_event[8], current_event[9].to_int())
				SignalHandler.emit_signal("modify_country_value", current_event[3], current_event[10], current_event[11].to_int())
				SignalHandler.emit_signal("modify_country_value", current_event[3], current_event[12], current_event[13].to_int())
			2:
				SignalHandler.emit_signal("modify_country_value", current_event[2], current_event[14], current_event[15].to_int())
				SignalHandler.emit_signal("modify_country_value", current_event[2], current_event[16], current_event[17].to_int())
				SignalHandler.emit_signal("modify_country_value", current_event[3], current_event[18], current_event[19].to_int())
				SignalHandler.emit_signal("modify_country_value", current_event[3], current_event[20], current_event[21].to_int())

func new_event_requested() -> void:
	generate_new_event()
