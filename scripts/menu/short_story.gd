extends CanvasLayer


func _on_return_pressed() -> void:
	Global.round = 1
	Global.first_use = true
	get_tree().change_scene_to_file("res://scenes/menu/match_tracker.tscn")
