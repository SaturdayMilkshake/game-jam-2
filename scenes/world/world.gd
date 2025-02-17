extends Node2D

func _on_back_to_title_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen/title_screen.tscn")
