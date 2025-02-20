extends Node

var turn: int = 0

func _ready() -> void:
	SignalHandler.connect("new_turn", Callable(self, "new_turn"))

func new_turn() -> void:
	turn += 1
	SignalHandler.emit_signal("turn_updated", turn)

func modify_country_value(_country: String, _attribute: String, _modifier: int) -> void:
	pass
