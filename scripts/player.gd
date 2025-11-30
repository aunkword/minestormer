extends CharacterBody2D

@export var speed = 70
@export var dash_speed = 120
@export var dash_duration = 0.5
@export var dash_cooldown = 2

@onready var game: Node2D = $"../.."
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var tiles_1: TileMapLayer = %Tiles1
@onready var cover_1: TileMapLayer = %Cover1
@onready var tiles_2: TileMapLayer = %Tiles2
@onready var cover_2: TileMapLayer = %Cover2
@onready var tiles_3: TileMapLayer = %Tiles3
@onready var cover_3: TileMapLayer = %Cover3
@onready var hitbox: CollisionShape2D = $CollisionShape2D
@onready var explode: AudioStreamPlayer = $Explosion
@onready var reveal: AudioStreamPlayer = $Reveal
@onready var flags_1: TileMapLayer = %Flags1
@onready var flags_2: TileMapLayer = %Flags2
@onready var flags_3: TileMapLayer = %Flags3
@onready var invulnerability_timer: Timer = $InvulnerabilityTimer
@onready var death_sound: AudioStreamPlayer = $"Death-sound"
@onready var death_timer: Timer = $DeathTimer

const EXPLOSION = preload("res://scenes/explosion.tscn")

var current_countdown_value = 1
var is_dashing = false
var dash_timer = 0.0
var dash_direction = Vector2.ZERO

var input = true

var width = 9
func _ready():
	add_to_group("Player")

func change_pos():
	var start_cell # player start position
	var level = game.get_level()
	if level == 1:
		width = get_parent().get_parent().LEVEL_ONE_WIDTH
		start_cell = Vector2i((width/2*get_parent().get_parent().TILE_SIZE), (width/2*get_parent().get_parent().TILE_SIZE))
	if level == 2:
		width = get_parent().get_parent().LEVEL_TWO_WIDTH
		start_cell = Vector2i((width/2*get_parent().get_parent().TILE_SIZE), (width/2*get_parent().get_parent().TILE_SIZE))
	if level == 3:
		width = get_parent().get_parent().LEVEL_THREE_WIDTH
		start_cell = Vector2i((width/2*get_parent().get_parent().TILE_SIZE), (width/2*get_parent().get_parent().TILE_SIZE))
	global_position = start_cell + Vector2i(get_parent().get_parent().TILE_SIZE/2, get_parent().get_parent().TILE_SIZE/2)

func _physics_process(delta: float) -> void:
	# get direction input
	var flags
	var level = game.get_level()
	var cover
	var dir = Input.get_vector("key.left", "key.right", "key.up", "key.down")
	if input == true:
		if Input.is_action_just_pressed("key.dash") and game.get_dash_count() > 0 and dir != Vector2.ZERO:
			game.decrement_dash()
			is_dashing = true
			dash_timer = dash_duration
			dash_direction = dir

		# update dash timer
		if is_dashing:
			velocity = dash_direction * dash_speed
			dash_timer -= delta
			if dash_timer <= 0:
				is_dashing = false
		else:
			# normal movement when not dashing
			if dir != Vector2.ZERO:
				velocity = dir * speed
			else:
				velocity = velocity.move_toward(Vector2.ZERO, speed)
		# animations
		if dir != Vector2.ZERO:
			sprite.play("run")
		else:
			sprite.play("idle")
		# flip the sprite
		if dir.x != 0:
			sprite.flip_h = dir.x < 0
		move_and_slide()
		##-----------------------------------------------------------------------------------
		if level == 1:
			flags = flags_1
			cover = cover_1
		elif level == 2:
			flags = flags_2
			cover = cover_2
		elif level == 3:
			flags = flags_3
			cover = cover_3
		if Input.is_action_just_pressed("key.interact"):
			var tile_pos = cover.local_to_map(global_position)
			if cover.get_cell_source_id(tile_pos) != -1:
				reveal_tile(tile_pos)
				game.check_win_condition()
		if Input.is_action_just_pressed("click.flag"):
			manage_flag()
		if Input.is_action_just_pressed("key.invuln"):
			use_invulnerability()
	##-----------------------------------------------------------------------------------

func manage_flag():
	var cover
	var flags
	var level = game.get_level()
	if game.get_level() == 1:
		flags = flags_1
		cover = cover_1
	elif game.get_level() == 2:
		flags = flags_2
		cover = cover_2
	elif game.get_level() == 3:
		flags = flags_3
		cover = cover_3
	var tile_pos = cover.local_to_map(global_position)
	if cover.get_cell_source_id(tile_pos) != -1:
		if flags.get_cell_source_id(tile_pos) == -1 && game.get_flags_count() > 0:
			flags.place_flag(tile_pos)
			game.decrement_flags(level)
		elif flags.get_cell_source_id(tile_pos) != -1:
			flags.remove_flag(tile_pos)
			game.increment_flags(level)
		game.check_win_condition()

func reveal_tile(tile_pos: Vector2i):
	# interaction
	# if it has a flag, does nothing
	var flags
	var cover
	var tiles
	if game.get_level() == 1:
		flags = flags_1
		cover = cover_1
		tiles = tiles_1
	elif game.get_level() == 2:
		flags = flags_2
		cover = cover_2
		tiles = tiles_2
	elif game.get_level() == 3:
		flags = flags_3
		cover = cover_3
		tiles = tiles_3
	var level = game.get_level()
	# if there isn't a flag on the tile
	if !flags.has_flag(tile_pos):
		# and the cover exists
		if cover.get_cell_source_id(tile_pos) != -1:
			# if it's not a mine, play a correct sound
			if !tiles.is_mine(tile_pos, level):
				cover.erase_cell(tile_pos)
				reveal.play()
				game.increment_cleared_tiles()
				if(level == 1):
					game.increase_score(10)
				elif(level == 2):
					game.increase_score(20)
				else:
					game.increase_score(30)
				# if it's blank, reveal adjacent blank and number tiles
				if tiles.is_blank(tile_pos):
					reveal_blanks_and_adjacent_numbers(tile_pos)
			else:
				# if you have a lifeline manage flag
				if(game.get_lifeline_count() > 0):
					manage_flag()
					game.decrement_lifeline()
				# if it's a mine, spawn a bomb, and then play a bomb sound
				else:
					cover.erase_cell(tile_pos)
					mine_explode(tile_pos)
					game.decrement_flags(level)
					explode.play()
			

func reveal_blanks_and_adjacent_numbers(tile_pos: Vector2i):
	var cover
	var tiles
	var flags
	var score
	if game.get_level() == 1:
		cover = cover_1
		tiles = tiles_1
		flags = flags_1
		score = 10
	elif game.get_level() == 2:
		cover = cover_2
		tiles = tiles_2
		flags = flags_2
		score = 20
	elif game.get_level() == 3:
		cover = cover_3
		tiles = tiles_3
		flags = flags_3
		score = 30
	var neighbors = tiles.get_all_surrounding_cells(tile_pos, width)
	
	for n in neighbors:
		if cover.get_cell_source_id(n) == -1 || flags.get_cell_source_id(n) != -1:
			continue
		if tiles.is_blank(n):
			# check orthogonal neighbors
			var change = n - tile_pos
			if change.x == 0 or change.y == 0:
				# reveal blanks
				reveal_tile(n)
		else:
			# reveals number neighbors of blanks
			cover.erase_cell(n)
			game.increment_cleared_tiles()
			game.increase_score(score)
func mine_explode(tile_pos: Vector2i):
	var cover
	if game.get_level() == 1:
		cover = cover_1
	elif game.get_level() == 2:
		cover = cover_2
	elif game.get_level() == 3:
		cover = cover_3
	var bomb = EXPLOSION.instantiate()
	bomb.global_position = cover.map_to_local(tile_pos)
	# scale the collision shape to cover a 3x3 area of tiles
	bomb.scale = Vector2(1.25, 1.25)
	get_tree().current_scene.add_child(bomb)

func give_dash():
	game.increment_dash()

func give_lifeline():
	game.increment_lifeline()
## ------------------------------------------------------
func giveInvulnerability():
	if(game.get_level() == 1):
		invulnerability_timer.wait_time = 2
	elif(game.get_level() == 2):
		invulnerability_timer.wait_time = 5
	else:
		invulnerability_timer.wait_time = 7
	game.increment_invulnerability()

func use_invulnerability():
	collision_layer &= ~1
	modulate = Color(1, 1, 1, 0.5)
	invulnerability_timer.start()
	game.decrement_invulnerability()

func _on_invulnerability_timer_timeout() -> void:
	collision_layer |= 1
	modulate = Color(1, 1, 1, 1)
## ------------------------------------------------------

func die():
	input = false
	sprite.play("idle")
	death_sound.play()
	await get_tree().create_timer(0.2).timeout
	game.show_death_screen()
