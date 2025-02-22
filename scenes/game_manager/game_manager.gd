extends Node

var turn: int = 0
var influence: int = 0

#Win / Lose Conditions
var peace_process_active: bool = false
var peace_progress: int = 0

var war_progress_active: bool = false
var war_progress: int = 0

func _ready() -> void:
	SignalHandler.connect("new_turn", Callable(self, "new_turn"))
	SignalHandler.connect("influence_used", Callable(self, "influence_used"))
	SignalHandler.connect("update_global_status", Callable(self, "update_global_status"))
	call_deferred("start_game")

func start_game() -> void:
	SignalHandler.emit_signal("game_started")
	SignalHandler.emit_signal("turn_updated", turn)

func new_turn() -> void:
	turn += 1
	influence += 1
	if influence >= 5:
		influence = 5
	SignalHandler.emit_signal("turn_updated", turn)
	SignalHandler.emit_signal("influence_updated", influence)
	
func influence_used(country: String, attribute: String, add_mode: bool) -> void:
	if influence > 0:
		influence -= 1
		if add_mode:
			SignalHandler.emit_signal("modify_country_value", country, attribute, 1)
		else:
			SignalHandler.emit_signal("modify_country_value", country, attribute, -1)
		SignalHandler.emit_signal("influence_updated", influence)
		SignalHandler.emit_signal("update_country_info", country)
	
func update_global_status(status: String, amount: int) -> void:
	match status:
		"Peace":
			pass
		"War":
			pass
