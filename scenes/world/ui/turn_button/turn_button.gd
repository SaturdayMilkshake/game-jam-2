extends Button

var game_active: bool = false

func _ready() -> void:
	SignalHandler.connect("new_turn", Callable(self, "new_turn"))
	SignalHandler.connect("turn_updated", Callable(self, "turn_updated"))
	SignalHandler.connect("finished_all_events_this_turn", Callable(self, "events_completed"))
	SignalHandler.connect("game_started", Callable(self, "game_started"))

func _on_pressed() -> void:
	if !game_active:
		game_active = true
		SignalHandler.emit_signal("game_started")
		self.disabled = true
	else:
		self.disabled = true
	SignalHandler.emit_signal("new_turn")
	$Click.play()

func turn_updated(turn: int) -> void:
	self.text = "Year " + str(turn + 1940)

func events_completed() -> void:
	self.disabled = false

func new_turn() -> void:
	self.disabled = true

func game_started() -> void:
	self.disabled = true
