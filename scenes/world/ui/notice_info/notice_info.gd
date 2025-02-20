extends Control

func _ready() -> void:
	SignalHandler.connect("new_notice", Callable(self, "new_notice"))
	self.visible = false

func new_notice() -> void:
	self.visible = true
