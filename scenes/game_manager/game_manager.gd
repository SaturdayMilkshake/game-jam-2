extends Node

var turn: int = 0
var influence: int = 0

#Win / Lose Conditions
var peace_process_active: bool = false
var peace_progress: int = 0

func _ready() -> void:
	SignalHandler.connect("new_turn", Callable(self, "new_turn"))

func new_turn() -> void:
	turn += 1
	influence += 1
	SignalHandler.emit_signal("turn_updated", turn)
