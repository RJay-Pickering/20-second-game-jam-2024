extends CanvasLayer


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/short_story.tscn")


func _on_controls_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/controls.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_start_mouse_entered() -> void:
	$player.play("default")


func _on_start_mouse_exited() -> void:
	$player.stop()


func _on_controls_mouse_entered() -> void:
	$enemy1.play("default")


func _on_controls_mouse_exited() -> void:
	$enemy1.stop()


func _on_quit_mouse_entered() -> void:
	$enemy2.play("default")


func _on_quit_mouse_exited() -> void:
	$enemy2.stop()
