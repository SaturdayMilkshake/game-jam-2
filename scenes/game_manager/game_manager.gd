extends Node

var turn: int = 0
var influence: int = 0

#Attribute Conditions
var critical_economy: int = 0
var critical_stability: int = 0
var critical_military: int = 0
var critical_cooperation: int = 0

var full_cooperation: int = 0

#Win / Lose Conditions
var peace_process_active: bool = true
var peace_progress: int = 0

var war_progress_active: bool = false
var war_progress: int = 0

func _ready() -> void:
	SignalHandler.connect("new_turn", Callable(self, "new_turn"))
	SignalHandler.connect("influence_used", Callable(self, "influence_used"))
	#Statuses
	SignalHandler.connect("no_economy", Callable(self, "no_economy"))
	SignalHandler.connect("no_stability", Callable(self, "no_stability"))
	SignalHandler.connect("no_military", Callable(self, "no_military"))
	SignalHandler.connect("excess_military", Callable(self, "excess_military"))
	SignalHandler.connect("no_cooperation", Callable(self, "no_cooperation"))
	SignalHandler.connect("excess_cooperation", Callable(self, "excess_cooperation"))
	call_deferred("start_game")

func start_game() -> void:
	SignalHandler.emit_signal("game_started")
	SignalHandler.emit_signal("turn_updated", turn)

func new_turn() -> void:
	critical_economy = 0
	critical_stability = 0
	critical_military = 0
	critical_cooperation = 0
	
	full_cooperation = 0
	
	turn += 1
	influence += 1
	if influence >= 5:
		influence = 5
	SignalHandler.emit_signal("turn_updated", turn)
	SignalHandler.emit_signal("influence_updated", influence)
	call_deferred("check_critical_values")
	
func check_critical_values() -> void:
	if critical_economy >= 4:
		pass
	if critical_stability >= 4:
		pass
	if critical_military >= 3:
		war_progress_active = true
	if critical_cooperation >= 5:
		SignalHandler.emit_signal("game_over", "Broken Treaty")
	
	update_global_status("War")
	update_global_status("Peace")
	check_win_lose_conditions()
	
func check_win_lose_conditions() -> void:
	if war_progress >= 100:
		SignalHandler.emit_signal("game_over", "War")
	elif peace_progress >= 100:
		SignalHandler.emit_signal("game_over", "Peace")
	
func influence_used(country: String, attribute: String, add_mode: bool) -> void:
	if influence > 0:
		influence -= 1
		if add_mode:
			SignalHandler.emit_signal("modify_country_value", country, attribute, 1)
		else:
			SignalHandler.emit_signal("modify_country_value", country, attribute, -1)
		SignalHandler.emit_signal("influence_updated", influence)
		SignalHandler.emit_signal("update_country_info", country)
	
func update_global_status(status: String) -> void:
	match status:
		"Peace":
			if peace_process_active:
				peace_progress += full_cooperation
				SignalHandler.emit_signal("update_global_status", "Peace", peace_progress)
		"War":
			if war_progress_active:
				war_progress += critical_military
				SignalHandler.emit_signal("update_global_status", "War", war_progress)

func no_economy() -> void:
	critical_economy += 1

func no_stability() -> void:
	critical_stability += 1
	
func no_military() -> void:
	critical_military += 1
	
func excess_military() -> void:
	critical_military += 1

func no_cooperation() -> void:
	critical_cooperation += 1

func excess_cooperation() -> void:
	full_cooperation += 1
