extends Node

@export var cooperation: int = 5

var self_action: bool = false

signal no_cooperation

func modify_cooperation(modifier: int) -> void:
	if !self_action:
		cooperation += modifier
	
	if cooperation <= 0:
		cooperation = 0
		self_action = true
		emit_signal("no_cooperation")
	if cooperation >= 10:
		cooperation = 10
		
