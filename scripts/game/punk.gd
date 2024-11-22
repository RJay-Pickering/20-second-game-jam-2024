extends CharacterBody2D

# Enemy properties
var speed: float = 100.0
var health: int = 100
var attack_damage: int = 10
var attack_range: float = 50.0
var attack_cooldown: float = 1.0
@export var target: CharacterBody2D
@export var enemy_health: ProgressBar
@onready var sprite = $AnimatedSprite2D
var can_attack: bool = true
var is_attacking: bool = false
var damaged = false

# Called every frame
func _process(delta: float) -> void:
	if target and not Global.is_someone_dead and not Global.pause_attack:
		if is_attacking == false and not damaged:
			var direction = (target.position - position).normalized()
			velocity.x = direction.x * speed
			
		if position.x > target.position.x:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		
		if damaged:
			var knockback = position.direction_to(target.position) * -500
			velocity.x = knockback.x
			move_and_collide(velocity * delta)
			await get_tree().create_timer(0.5).timeout
			damaged = false
		move_and_collide(velocity * delta)
		
		
		# Check if in attack range
		if position.distance_to(target.position) < attack_range and can_attack and not damaged:
			is_attacking = true
			attack()
			if position.x > target.position.x:
				sprite.flip_h = false
			else:
				sprite.flip_h = true
			await get_tree().create_timer(0.5).timeout
			is_attacking = false
		elif is_attacking == false and damaged == false:
			$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.stop()

# Attack function
func attack() -> void:
	can_attack = false
	$AnimatedSprite2D.play("punch")
	await get_tree().create_timer(0.5).timeout
	if position.distance_to(target.position) < attack_range:
		Global.pause_attack = true
		target.take_damage(attack_damage)
		await get_tree().create_timer(0.5).timeout
		Global.pause_attack = false
	if target.health > 0:
		await get_tree().create_timer(0.5).timeout
		can_attack = true

# Function to take damage
func take_damage(damage: int) -> void:
	health -= damage
	enemy_health.value = health
	damaged = true
	$AnimatedSprite2D.play("hurt")
	if health <= 0:
		die()

# Function to handle death
func die() -> void:
	Global.status += "EnemyDead"
	Global.is_someone_dead = true
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/menu/game_over.tscn")
