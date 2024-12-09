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

func _process(delta):
	if Global.first_use == false:
		var rng = RandomNumberGenerator.new()
		var random_integer = rng.randi_range(0, people.size() - 1)
		if !added_people.has(people[random_integer]):
			added_people.append(people[random_integer])
			people_len += 1
			if people_len == 2:
				label2.text = people[random_integer]
			elif people_len == 3:
				label3.text = people[random_integer]
			elif people_len == 4:
				label4.text = people[random_integer]
			elif people_len == 5:
				label5.text = people[random_integer]
			elif people_len == 6:
				label8.text = people[random_integer]
		
		if people_len == 6:
			Global.first_use = true
	
