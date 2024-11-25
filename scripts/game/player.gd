extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var player_health: ProgressBar
@export var enemy: CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var hurt_collision = $hurt/CollisionShape2D
@onready var up_strike_collision = $up_strike/CollisionShape2D
@onready var down_strike_collision = $down_strike/CollisionShape2D
@onready var sword_strike_collision = $sword_strike/CollisionShape2D
var damaged = false
var can_attack = true

var health = 10
var is_jumping = false
var is_stand_attacking = false
var is_jump_attacking = false


func _ready() -> void:
	up_strike_collision.disabled = true
	down_strike_collision.disabled = true
	sword_strike_collision.disabled = true


func _physics_process(delta: float) -> void:
	if is_stand_attacking == false and not Global.is_someone_dead:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
		else:
			is_jumping = false

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			if not is_jump_attacking and not damaged:
				$jump.play()
				sprite.play("jump")
			is_jumping = true
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		if damaged == false:
			var direction := Input.get_axis("left", "right")
			if direction:
				if is_jumping == false and not is_jump_attacking and not damaged:
					sprite.play("walk")
				direction_helper(direction)
				velocity.x = direction * SPEED
			else:
				if is_jumping == false and not is_jump_attacking and not damaged:
					sprite.play("Idle")
					idle_damage()
				velocity.x = move_toward(velocity.x, 0, SPEED)
			move_and_slide()
		if damaged:
			var knockback = position.direction_to(enemy.position) * -400
			velocity.x = knockback.x
			move_and_slide()
			await get_tree().create_timer(0.5).timeout
			damaged = false
		
		attack_helper(delta)

func idle_damage():
	player_health.value -= 0.05
	health = player_health.value
	if health <= 0:
		die()

func direction_helper(direction):
	# Facing Right
	if direction > 0:
		sprite.flip_h = false
		up_strike_collision.position.x = 7
		down_strike_collision.position.x = 8
		sword_strike_collision.position.x = 29.25
	
	# Facing Left
	else:
		sprite.flip_h = true
		up_strike_collision.position.x = -7
		down_strike_collision.position.x = -8
		sword_strike_collision.position.x = -29.25

func attack_helper(delta):
	if can_attack and not damaged:
		if Input.is_action_pressed("attack") and Input.is_action_pressed("down") and is_on_floor():
			$miss.play()
			sprite.play("attack-slash")
			is_stand_attacking = true
			sword_strike_collision.disabled = false
			can_attack = false
			await get_tree().create_timer(0.5).timeout
			is_stand_attacking = false
			sword_strike_collision.disabled = true
		
		elif Input.is_action_pressed("attack") and Input.is_action_pressed("up") and is_on_floor():
			$miss.play()
			sprite.play("attack-high")
			is_stand_attacking = true
			up_strike_collision.disabled = false
			can_attack = false
			await get_tree().create_timer(0.5).timeout
			is_stand_attacking = false
			up_strike_collision.disabled = true
		
		elif Input.is_action_pressed("attack") and is_on_floor():
			$miss.play()
			sprite.play("attack-low")
			is_stand_attacking = true
			down_strike_collision.disabled = false
			can_attack = false
			await get_tree().create_timer(0.5).timeout
			is_stand_attacking = false
			down_strike_collision.disabled = true
		
		if Input.is_action_pressed("attack") and not is_on_floor():
			$miss.play()
			sprite.play("attack-jump")
			is_jump_attacking = true
			sword_strike_collision.disabled = false
			can_attack = false
			await get_tree().create_timer(0.5).timeout
			is_jump_attacking = false
			sword_strike_collision.disabled = true
	else:
		await get_tree().create_timer(1.0).timeout
		can_attack = true

func take_damage(damage: int) -> void:
	player_health.value -= damage
	health = player_health.value
	damaged = true
	sprite.play("hurt")
	if health <= 0:
		die()

func die():
	Global.status += "PlayerDead"
	Global.is_someone_dead = true
	sprite.play("hurt")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/menu/game_over.tscn")


func _on_up_strike_area_entered(area: Area2D) -> void:
	if area.name == "HurtBox":
		var enemy: CharacterBody2D = area.get_parent()
		$hit.play()
		enemy.take_damage(10)
		up_strike_collision.disabled = true


func _on_down_strike_area_entered(area: Area2D) -> void:
	if area.name == "HurtBox":
		var enemy: CharacterBody2D = area.get_parent()
		$hit.play()
		enemy.take_damage(5)
		down_strike_collision.disabled = true


func _on_sword_strike_area_entered(area: Area2D) -> void:
	if area.name == "HurtBox":
		var enemy: CharacterBody2D = area.get_parent()
		$blade.play()
		enemy.take_damage(15)
		sword_strike_collision.disabled = true
