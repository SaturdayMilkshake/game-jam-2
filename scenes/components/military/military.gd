extends Node

@export var military: int = 10

func modify_military(modifier: int) -> void:
	military += modifier
	
	if military <= 0:
		military = 0
	if military >= 10:
		military = 10
