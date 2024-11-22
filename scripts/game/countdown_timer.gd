extends CanvasLayer


@onready var counter = $counter
var counting = false

func _process(delta: float) -> void:
	#if Global.is_someone_dead:
		#await get_tree().create_timer(0.5).timeout
		#get_tree().paused = false
	if counting == false and not Global.pause_attack:
		counting = true
		await get_tree().create_timer(1.5).timeout
		Global.countdown -= 1
		counter.text = str(Global.countdown)
		counting = false
	
	if Global.countdown == 0:
		get_tree().paused = true
		Global.status += "TimeOut"
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://scenes/menu/game_over.tscn")
	
