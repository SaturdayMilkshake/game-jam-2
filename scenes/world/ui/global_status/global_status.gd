extends Control

func _ready() -> void:
	SignalHandler.connect("update_global_status", Callable(self, "update_global_status"))

func update_global_status(status: String, amount: int) -> void:
	match status:
		"War":
			var tween = create_tween()
			tween.tween_property($HBoxContainer/WarProgress/ProgressBar, "value", amount, 1).set_trans(Tween.TRANS_SINE)
		"Peace":
			var tween = create_tween()
			tween.tween_property($HBoxContainer/PeaceProcess/ProgressBar, "value", amount, 1).set_trans(Tween.TRANS_SINE)
