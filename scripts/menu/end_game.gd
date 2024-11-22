extends CanvasLayer


func _ready() -> void:
	get_tree().paused = false
	var title: Label = $CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer/title
	var reason: Label = $CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer/reason
	if Global.status == "PlayerDead":
		title.label_settings.font_color = Color(0.827, 0, 0.204)
		reason.label_settings.font_color = Color(1, 0.429, 0.445)
		reason.text = """YOU LOSE"""
	elif Global.status == "TimeOut":
		title.label_settings.font_color = Color(0.827, 0, 0.204)
		reason.label_settings.font_color = Color(1, 0.429, 0.445)
		reason.text = """TIME RAN OUT"""
	elif Global.status == "EnemyDead":
		title.label_settings.font_color = Color(0, 0.537, 0.22)
		reason.label_settings.font_color = Color(0.21, 0.767, 0)
		reason.text = """YOU WIN"""
	elif Global.status == "EnemyDeadPlayerDead" or Global.status == "PlayerDeadEnemyDead":
		title.label_settings.font_color = Color(1, 0.459, 0.11)
		reason.label_settings.font_color = Color(0.935, 0.518, 0)
		reason.text = """TIE"""
	elif Global.status == "EnemyDeadTimeOut" or Global.status == "TimeOutEnemyDead":
		title.label_settings.font_color = Color(1, 0.459, 0.11)
		reason.label_settings.font_color = Color(0.935, 0.518, 0)
		reason.text = """YOU LOST AND RAN OUT OF TIME"""
	elif Global.status == "PlayerDeadTimeOut" or Global.status == "TimeOutPlayerDead":
		title.label_settings.font_color = Color(1, 0.459, 0.11)
		reason.label_settings.font_color = Color(0.935, 0.518, 0)
		reason.text = """YOU WON THE FIGHT, BUT LOST THE MATCH DUE TO TIME"""
	else:
		title.label_settings.font_color = Color(1, 0.459, 0.11)
		reason.label_settings.font_color = Color(0.935, 0.518, 0)
		reason.text = """WOW, YOU WERE ABLE TO WIN, LOSE, AND RUN OUT OF TIME"""

# --------------- Game over button controls for GameOver scene ---------------
func _on_retry_pressed() -> void:
	Global.countdown = 20
	Global.status = ""
	Global.is_someone_dead = false
	Global.pause_attack = false
	get_tree().change_scene_to_file("res://scenes/game/arena.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
