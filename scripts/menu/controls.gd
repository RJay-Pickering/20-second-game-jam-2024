extends CanvasLayer


func _on_return_pressed() -> void:
	$"../menu".visible = true
	$"../controls".visible = false


func _on_return_mouse_entered() -> void:
	$CenterContainer/enemy.play("default")


func _on_return_mouse_exited() -> void:
	$CenterContainer/enemy.play("idle")
