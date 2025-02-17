extends Node

var turn: int = 0

func new_turn() -> void:
	SignalHandler.emit_signal("new_turn", turn)

func modify_country_value(_country: String, _attribute: String, _modifier: int) -> void:
	pass
