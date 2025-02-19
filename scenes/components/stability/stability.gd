extends Node

@export var stability: int = 10

signal no_stability

func modify_stability(modifier: int) -> void:
	stability += modifier
	
	if stability <= 0:
		stability = 0
		emit_signal("no_stability")
