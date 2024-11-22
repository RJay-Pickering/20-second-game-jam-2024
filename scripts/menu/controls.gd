extends CanvasLayer


func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")


func _on_return_mouse_entered() -> void:
	$CenterContainer/enemy.play("default")


func _on_return_mouse_exited() -> void:
	$CenterContainer/enemy.stop()
