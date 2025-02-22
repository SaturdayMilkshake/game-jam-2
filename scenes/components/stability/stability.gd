extends Node

@export var stability: int = 10

func modify_stability(modifier: int) -> void:
	stability += modifier
	
	if stability <= 0:
		stability = 0
	if stability >= 10:
		stability = 10
