extends Control

var target: String = ""

func _ready() -> void:
	SignalHandler.connect("transition_requested", Callable(self, "transition_requested"))
	transition_requested(false, "")

func transition_requested(fade_in: bool, new_target: String) -> void:
	target = new_target
	if fade_in:
		var tween: Tween = create_tween()
		tween.tween_property($ColorRect, "modulate", Color(0.0, 0.0, 0.0, 1.0), 1)
		tween.tween_callback(change_to_scene)
		set_visibility(true)
	else:
		var tween: Tween = create_tween()
		tween.tween_property($ColorRect, "modulate", Color(0.0, 0.0, 0.0, 0.0), 1)
		tween.tween_callback(set_visibility)

func change_to_scene() -> void:
	if FileAccess.file_exists(target):
		get_tree().change_scene_to_file(target)

func set_visibility(status: bool = false) -> void:
	self.visible = status
