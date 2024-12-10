extends CanvasLayer

var status = ""
@onready var retry_btn: Button = $CenterContainer/VBoxContainer/VBoxContainer/retry


func _ready() -> void:
	get_tree().paused = false
	var title: Label = $CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer/title
	var reason: Label = $CenterContainer/VBoxContainer/HBoxContainer/VBoxContainer/reason
	
	if Global.status == "PlayerDead":
		status = "lose"
		title.label_settings.font_color = Color(0.827, 0, 0.204)
		reason.label_settings.font_color = Color(1, 0.429, 0.445)
		reason.text = """YOU LOSE"""
	elif Global.status == "TimeOut":
		status = "lose"
		title.label_settings.font_color = Color(0.827, 0, 0.204)
		reason.label_settings.font_color = Color(1, 0.429, 0.445)
		reason.text = """TIME RAN OUT"""
	elif Global.status == "EnemyDead":
		status = "win"
		title.label_settings.font_color = Color(0, 0.537, 0.22)
		reason.label_settings.font_color = Color(0.21, 0.767, 0)
		var rng = RandomNumberGenerator.new()
		var random_integer = rng.randi_range(1000, 100000)
		Global.gold_total += random_integer
		reason.text = "You Win " + str(random_integer) + " GOLD."
	elif Global.status == "EnemyDeadPlayerDead" or Global.status == "PlayerDeadEnemyDead":
		status = "lose"
		title.label_settings.font_color = Color(1, 0.459, 0.11)
		reason.label_settings.font_color = Color(0.935, 0.518, 0)
		reason.text = """TIE"""
	elif Global.status == "EnemyDeadTimeOut" or Global.status == "TimeOutEnemyDead":
		status = "lose"
		title.label_settings.font_color = Color(1, 0.459, 0.11)
		reason.label_settings.font_color = Color(0.935, 0.518, 0)
		reason.text = """YOU WON THE FIGHT, BUT LOST THE MATCH DUE TO TIME"""
	elif Global.status == "PlayerDeadTimeOut" or Global.status == "TimeOutPlayerDead":
		status = "lose"
		title.label_settings.font_color = Color(1, 0.459, 0.11)
		reason.label_settings.font_color = Color(0.935, 0.518, 0)
		reason.text = """YOU LOST AND RAN OUT OF TIME"""
	else:
		status = "win"
		title.label_settings.font_color = Color(1, 0.459, 0.11)
		reason.label_settings.font_color = Color(0.935, 0.518, 0)
		reason.text = """WOW, YOU WERE ABLE TO WIN, LOSE, AND RUN OUT OF TIME"""

# --------------- Game over button controls for GameOver scene ---------------
func _process(delta):
	if status == "lose" and $Lose.playing == false:
		$Lose.playing = true
		retry_btn.text = "Retry"
	elif status == "win" and $Win.playing == false:
		retry_btn.text = "Next Fight"
		$Win.playing = true

func _on_retry_pressed() -> void:
	if status == "lose":
		Global.countdown = 20
		Global.status = ""
		Global.is_someone_dead = false
		Global.pause_attack = false
		Global.special_usage = 3
		get_tree().change_scene_to_file("res://scenes/game/arena.tscn")
	else:
		Global.round += 1
		Global.countdown = 20
		Global.status = ""
		Global.is_someone_dead = false
		Global.pause_attack = false
		Global.special_usage = 3
		get_tree().change_scene_to_file("res://scenes/menu/match_tracker.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
