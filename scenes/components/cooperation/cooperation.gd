extends Node

@export var cooperation: int = 5

signal no_cooperation

func modify_cooperation(modifier: int) -> void:
	cooperation += modifier
	
	if cooperation <= 0:
		cooperation = 0
		emit_signal("no_cooperation")
