extends Node

@export var economy: int = 10

signal no_economy

func modify_economy(modifier: int) -> void:
	economy += modifier
	
	if modifier > 0:
		pass
	
	if economy <= 0:
		economy = 0
		emit_signal("no_economy")
