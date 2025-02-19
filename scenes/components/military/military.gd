extends Node

@export var military: int = 10

signal no_military

func modify_military(modifier: int) -> void:
	military += modifier
	
	if military <= 0:
		military = 0
		emit_signal("no_military")
