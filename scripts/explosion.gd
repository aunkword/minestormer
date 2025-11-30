extends Area2D

@export var screen_time := 0.65

const EXPLOSION = preload("res://scenes/explosion.tscn")
@onready var explosion: AnimatedSprite2D = $Explosion

func _ready():
	#print("BOOM: ", global_position)
	await get_tree().process_frame
	explosion.play()
	await get_tree().create_timer(screen_time).timeout
	for body in get_overlapping_bodies():
		_on_Explosion_body_entered(body)
		
	body_entered.connect(_on_Explosion_body_entered)
	queue_free()

func _on_Explosion_body_entered(body: Node) -> void:
	print("BOOM: ", global_position)
	if body.name == "Player":
		body.die()
