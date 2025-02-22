extends Node

@export var economy: int = 10

func modify_economy(modifier: int) -> void:
	economy += modifier
	
	if economy <= 0:
		economy = 0
	if economy >= 10:
		economy = 10
