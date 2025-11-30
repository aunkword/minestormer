extends Node2D

# tile size
const TILE_SIZE : int = 24
# X*X grid
const LEVEL_ONE_WIDTH : int = 9
const LEVEL_TWO_WIDTH : int = 11
const LEVEL_THREE_WIDTH : int = 13
# total mines per level
const LEVEL_ONE_MINES : int = LEVEL_ONE_WIDTH * LEVEL_ONE_WIDTH / 9
const LEVEL_TWO_MINES : int = LEVEL_TWO_WIDTH * LEVEL_TWO_WIDTH / 9
const LEVEL_THREE_MINES : int = LEVEL_THREE_WIDTH * LEVEL_THREE_WIDTH / 9
# number of flags per level
var level_one_flags: int = LEVEL_ONE_MINES
var level_two_flags: int = LEVEL_TWO_MINES
var level_three_flags: int = LEVEL_THREE_MINES
# level counter
var level_counter: int = 1
var cleared_tiles = 0
# power up counters
var dashes = 0
var invulnerabilities = 0
var lifelines = 0

var paused = false

var final_score = 0
var total_time_in_secs = 0

@onready var level_1: Node2D = $Level1
@onready var level_2: Node2D = $Level2
@onready var level_3: Node2D = $Level3
@onready var borders_1: TileMapLayer = %Borders1
@onready var borders_2: TileMapLayer = %Borders2
@onready var borders_3: TileMapLayer = %Borders3
@onready var flag_label: Label = $UI/FlagCounter/Label
@onready var flag_counter: HBoxContainer = $UI/FlagCounter
@onready var invulnerbility_counter: HBoxContainer = $UI/InvulnerbilityCounter
@onready var invulnerability_label: Label = $UI/InvulnerbilityCounter/Label
@onready var dash_label: Label = $UI/DashCounter/Label
@onready var dash_counter: HBoxContainer = $UI/DashCounter
@onready var lifeline_label: Label = $UI/LifelineCounter/Label
@onready var lifeline_counter: HBoxContainer = $UI/LifelineCounter
@onready var game_time: HBoxContainer = $UI/GameTime
@onready var cannons: Node2D = $Cannons
@onready var game_timer: Timer = $GameTimer
@onready var time_label: Label = $UI/GameTime/TimeLabel
@onready var player: CharacterBody2D = $Player/Player
@onready var ui: CanvasLayer = $UI

@onready var level_music: AudioStreamPlayer = $"Level-music"


func _ready() -> void:
	level_music.play()
	
	level_3.level_3_clear()
	level_1.level_1_lay()
	cannons.set_cannons(level_counter)
	game_timer.start()
	
	flag_counter.scale = Vector2(2, 2)
	invulnerbility_counter.scale = Vector2(2, 2)
	dash_counter.scale = Vector2(2, 2)
	lifeline_counter.scale = Vector2(2, 2)
	game_time.scale = Vector2(2, 2)
	display_flag_count()
	display_invulnerability_count()
	display_dash_count()
	display_lifeline_count()

func show_winning_screen():
	var winning_scene = preload("res://scenes/win_screen.tscn").instantiate()
	add_child(winning_scene)
	winning_scene.set_score(final_score+(600-total_time_in_secs))
	player.set_physics_process(false)
	game_timer.stop()
	player.queue_free()
	ui.queue_free()

func show_death_screen():
	var death_scene = preload("res://scenes/death_screen.tscn").instantiate()
	add_child(death_scene)
	death_scene.set_score(final_score+(600-total_time_in_secs))
	player.set_physics_process(false)
	game_timer.stop()
	player.queue_free()
	ui.queue_free()

#func _input(event):
#	if Input.is_action_pressed("key.pause"):
#		get_tree().paused = true

func increase_score(score):
	final_score += score
func get_final_score():
	return final_score

# display flag count per level
func display_flag_count():
	if level_counter == 1:
		display_flag_count_1()
	if level_counter == 2:
		display_flag_count_2()
	if level_counter == 3:
		display_flag_count_3()
func display_flag_count_1():
	flag_label.text = str(level_one_flags)
func display_flag_count_2():
	flag_label.text = str(level_two_flags)
func display_flag_count_3():
	flag_label.text = str(level_three_flags)
## --------------------------------------------------------
func display_invulnerability_count():
	invulnerability_label.text = str(invulnerabilities)
func increment_invulnerability():
	invulnerabilities += 1
	display_invulnerability_count()
func decrement_invulnerability():
	invulnerabilities -= 1
	display_invulnerability_count()
func get_invulnerability_count():
	return dashes
##---------------------------------------------------------
func display_dash_count():
	dash_label.text = str(dashes)
func increment_dash():
	dashes += 1
	display_dash_count()
func decrement_dash():
	dashes -= 1
	display_dash_count()
func get_dash_count():
	return dashes
##---------------------------------------------------------
func display_lifeline_count():
	lifeline_label.text = str(lifelines)
func increment_lifeline():
	lifelines += 1
	display_lifeline_count()
func decrement_lifeline():
	lifelines -= 1
	display_lifeline_count()
func get_lifeline_count():
	return lifelines
##---------------------------------------------------------

# flag count getters
func get_flags_count():
	if level_counter == 1:
		return get_flags_count_1()
	if level_counter == 2:
		return get_flags_count_2()
	if level_counter == 3:
		return get_flags_count_3()
func get_flags_count_1() -> int:
	return level_one_flags
func get_flags_count_2() -> int:
	return level_two_flags
func get_flags_count_3() -> int:
	return level_three_flags

# flag incrementers/decrementers
func increment_flags(level):
	if level == 1:
		increment_flags_1()
	if level == 2:
		increment_flags_2()
	if level == 3:
		increment_flags_3()
func decrement_flags(level):
	if level == 1:
		decrement_flags_1()
	if level == 2:
		decrement_flags_2()
	if level == 3:
		decrement_flags_3()

func increment_flags_1():
	level_one_flags += 1
	display_flag_count_1()
func decrement_flags_1():
	level_one_flags -= 1
	display_flag_count_1()
func increment_flags_2():
	level_two_flags += 1
	display_flag_count_2()
func decrement_flags_2():
	level_two_flags -= 1
	display_flag_count_2()
func increment_flags_3():
	level_three_flags += 1
	display_flag_count_3()
func decrement_flags_3():
	level_three_flags -= 1
	display_flag_count_3()

func get_width(level):
	if level == 1:
		return LEVEL_ONE_WIDTH
	if level == 2:
		return LEVEL_TWO_WIDTH
	if level == 3:
		return LEVEL_THREE_WIDTH

func get_total_mines(level):
	if level == 1:
		return LEVEL_ONE_MINES
	if level == 2:
		return LEVEL_TWO_MINES
	if level == 3:
		return LEVEL_THREE_MINES

func increment_cleared_tiles():
	cleared_tiles += 1

func check_win_condition():
	var total_mines = get_total_mines(level_counter)
	var safe_tiles = get_width(level_counter) * get_width(level_counter) - 9 - get_total_mines(level_counter)

	if cleared_tiles == safe_tiles:
		next_level()
		display_flag_count()
		cleared_tiles = 0
	if level_counter == 2:
		if(cleared_tiles == 0):
			clear_all_projectiles()
			level_1.level_1_clear()
			level_2.level_2_lay()
			cannons.set_cannons(level_counter)
	elif level_counter == 3:
		if(cleared_tiles == 0):
			clear_all_projectiles()
			level_2.level_2_clear()
			level_3.level_3_lay()
			cannons.set_cannons(level_counter)
	elif level_counter == 4:
		show_winning_screen()
	print(cleared_tiles)

func clear_all_projectiles():
	for bullet in get_tree().get_nodes_in_group("bullet"):
		bullet.queue_free()

func get_level() -> int:
	return level_counter
func next_level():
	level_counter += 1

func _on_game_timer_timeout() -> void:
	total_time_in_secs += 1
	var m = int(total_time_in_secs/60.0)
	var s = total_time_in_secs - m * 60
	time_label.text = '%02d:%02d' % [m,s]
