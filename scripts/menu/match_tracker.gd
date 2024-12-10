extends Control

@onready var label1 = $Label1
@onready var label2 = $Label2
@onready var label3 = $Label3
@onready var label4 = $Label4
@onready var label5 = $Label5
@onready var label6 = $Label6
@onready var label7 = $Label7
@onready var label8 = $Label8
@onready var label9 = $Label9
@onready var label10 = $Label10
@onready var label11 = $Label11
@onready var winner = $winner
var people = ["Jared, the punk", "Sarah, the brawler", "Zephyrus Bane", "Kira, the red swordsman", "Brutus Gutstomper", "Jacob, the dark wolf"]
var added_people = []
var people_len = 1
var rng = RandomNumberGenerator.new()
var random_integer = rng.randi_range(1, 2)
var status = ""
var loops = 0

func _process(delta):
	if Global.first_use == true and Global.round == 1:
		var rng = RandomNumberGenerator.new()
		var random_integer = rng.randi_range(0, people.size() - 1)
		if !added_people.has(people[random_integer]):
			added_people.append(people[random_integer])
			people_len += 1
			label1.text = "David (you)"
			if people_len == 2:
				Global.fighter1 = people[random_integer]
				label2.text = Global.fighter1
			elif people_len == 3:
				Global.fighter2 = people[random_integer]
				label3.text = Global.fighter2
			elif people_len == 4:
				Global.fighter3 = people[random_integer]
				label4.text = Global.fighter3
			elif people_len == 5:
				Global.fighter4 = people[random_integer]
				label5.text = Global.fighter4
			elif people_len == 6:
				Global.fighter5 = people[random_integer]
				label8.text = Global.fighter5
		
		if people_len == 6:
			Global.first_use = false
	elif Global.round == 2:
		label1.text = "David (you)"
		label2.text = Global.fighter1
		label3.text = Global.fighter2
		label4.text = Global.fighter3
		label5.text = Global.fighter4
		label6.text = "David (you)"
		label8.text = Global.fighter5
		
		if random_integer == 1:
			Global.fighter6 = Global.fighter2
			label7.text = Global.fighter6
		else:
			Global.fighter6 = Global.fighter3
			label7.text = Global.fighter6
		
	elif Global.round == 3:
		label1.text = "David (you)"
		label2.text = Global.fighter1
		label3.text = Global.fighter2
		label4.text = Global.fighter3
		label5.text = Global.fighter4
		label6.text = "David (you)"
		label8.text = Global.fighter5
		label9.text = "David (you)"
		label7.text = Global.fighter6
		
		if random_integer == 1:
			Global.fighter7 = Global.fighter6
			label10.text = Global.fighter7
		else:
			Global.fighter7 = Global.fighter5
			label10.text = Global.fighter7
	
	elif Global.round == 4:
		label1.text = "David (you)"
		label2.text = Global.fighter1
		label3.text = Global.fighter2
		label4.text = Global.fighter3
		label5.text = Global.fighter4
		label6.text = "David (you)"
		label8.text = Global.fighter5
		label9.text = "David (you)"
		label7.text = Global.fighter6
		label10.text = Global.fighter7
		label11.text = "David (you)"
		$winner.visible = true
		if loops == 0:
			$winner.text += """
			""" +  str(Global.gold_total) + " gold earned."
			loops += 1
		status = "win"
		
	if status == "win":
		await get_tree().create_timer(2.5).timeout
		get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
	else:
		await get_tree().create_timer(2.5).timeout
		get_tree().change_scene_to_file("res://scenes/game/arena.tscn")
	
