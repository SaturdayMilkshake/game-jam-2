extends Node

@export var cooperation: int = 5

var self_action: bool = false

func modify_cooperation(modifier: int) -> void:
	if !self_action:
		cooperation += modifier
	
	if cooperation <= 0:
		cooperation = 0
		self_action = true
	if cooperation >= 10:
		cooperation = 10
		
