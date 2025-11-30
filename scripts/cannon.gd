extends Node2D

@onready var game: Node2D = $"../.."
@onready var player: CharacterBody2D = $"../../Player/Player"
@onready var bullet = load("res://scenes/bullet.tscn")
@onready var dash = load("res://scenes/dash.tscn")
@onready var invulnerability = load("res://scenes/invulnerability.tscn")
@onready var life_saver = load("res://scenes/life_saver.tscn")
@onready var shoot_timer_1: Timer = $"../../ShootTimer1"
@onready var shoot_timer_2: Timer = $"../../ShootTimer2"
@onready var shoot_timer_3: Timer = $"../../ShootTimer3"
@onready var shoot_timer_4: Timer = $"../../ShootTimer4"

# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	if(player):
		look_at(player.global_position)
		rotation += deg_to_rad(90)

func shoot():
	var rand1 = randi_range(1, 20)
	var rand2 = randi_range(1, 3)
	if(rand1 != 1):
		var instance = bullet.instantiate()
		instance.direction = rotation
		instance.spawnPos = global_position
		instance.spawnRot = rotation
		game.add_child.call_deferred(instance)
	else:
		if(rand2 == 1):
			var instance = dash.instantiate()
			instance.direction = rotation
			instance.spawnPos = global_position
			instance.spawnRot = 0
			game.add_child.call_deferred(instance)
		elif(rand2 == 2):
			var instance = invulnerability.instantiate()
			instance.direction = rotation
			instance.spawnPos = global_position
			instance.spawnRot = 0
			game.add_child.call_deferred(instance)
		else:
			var instance = life_saver.instantiate()
			instance.direction = rotation
			instance.spawnPos = global_position
			instance.spawnRot = 0
			game.add_child.call_deferred(instance)

func _on_shoot_timer_1_timeout() -> void:
	shoot_timer_1.wait_time = randf_range(3.0, 5.0)
	if (visible && player):
		shoot()

func _on_shoot_timer_2_timeout() -> void:
	shoot_timer_2.wait_time = randf_range(3.0, 5.0)
	if (visible && player):
		shoot()
	
func _on_shoot_timer_3_timeout() -> void:
	shoot_timer_3.wait_time = randf_range(3.0, 5.0)
	if (visible && player):
		shoot()

func _on_shoot_timer_4_timeout() -> void:
	shoot_timer_4.wait_time = randf_range(3.0, 5.0)
	if (visible && player):
		shoot()
