extends CanvasLayer


func _on_start_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/menu/short_story.tscn")
	$menu.visible = false
	$ShortStory.visible = true


func _on_controls_pressed() -> void:
	$menu.visible = false
	$controls.visible = true


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_start_mouse_entered() -> void:
	$menu/player.play("default")


func _on_start_mouse_exited() -> void:
	$menu/player.play("idle")


func _on_controls_mouse_entered() -> void:
	$menu/enemy1.play("default")


func _on_controls_mouse_exited() -> void:
	$menu/enemy1.play("idle")


func _on_quit_mouse_entered() -> void:
	$menu/enemy2.play("default")


func _on_quit_mouse_exited() -> void:
	$menu/enemy2.play("idle")
