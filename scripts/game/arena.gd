extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimationPlayer.play("poison_movement")
	
	if Global.special_usage == 2:
		$CanvasLayer/usage3.value = 0
	elif Global.special_usage == 1:
		$CanvasLayer/usage3.value = 0
		$CanvasLayer/usage2.value = 0
	elif Global.special_usage == 0:
		$CanvasLayer/usage3.value = 0
		$CanvasLayer/usage2.value = 0
		$CanvasLayer/usage1.value = 0
