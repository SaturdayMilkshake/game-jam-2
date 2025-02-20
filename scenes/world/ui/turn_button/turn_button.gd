extends Button

var game_active: bool = false

func _ready() -> void:
	SignalHandler.connect("turn_updated", Callable(self, "turn_updated"))
	SignalHandler.connect("finished_all_events_this_turn", Callable(self, "events_completed"))

func _on_pressed() -> void:
	if !game_active:
		game_active = true
		SignalHandler.emit_signal("game_started")
		self.disabled = true
	else:
		self.disabled = true
	SignalHandler.emit_signal("new_turn")

func turn_updated(turn: int) -> void:
	self.text = "Turn " + str(turn)

func events_completed() -> void:
	self.disabled = false
