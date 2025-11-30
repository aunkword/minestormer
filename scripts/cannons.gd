extends Node2D

@onready var game: Node2D = $".."
@onready var cannon_1_1: Node2D = %Cannon1_1
@onready var cannon_1_2: Node2D = %Cannon1_2
@onready var cannon_2_1: Node2D = %Cannon2_1
@onready var cannon_2_2: Node2D = %Cannon2_2
@onready var cannon_2_3: Node2D = %Cannon2_3
@onready var cannon_2_4: Node2D = %Cannon2_4
@onready var cannon_3_1: Node2D = %Cannon3_1
@onready var cannon_3_2: Node2D = %Cannon3_2
@onready var cannon_3_3: Node2D = %Cannon3_3
@onready var cannon_3_4: Node2D = %Cannon3_4
@onready var cannon_3_5: Node2D = %Cannon3_5
@onready var cannon_3_6: Node2D = %Cannon3_6
@onready var cannon_3_7: Node2D = %Cannon3_7
@onready var cannon_3_8: Node2D = %Cannon3_8

func hide_cannons():
	cannon_1_1.visible = false
	cannon_1_2.visible = false
	cannon_2_1.visible = false
	cannon_2_2.visible = false
	cannon_2_3.visible = false
	cannon_2_4.visible = false
	cannon_3_1.visible = false
	cannon_3_2.visible = false
	cannon_3_3.visible = false
	cannon_3_4.visible = false
	cannon_3_5.visible = false
	cannon_3_6.visible = false
	cannon_3_7.visible = false
	cannon_3_8.visible = false

func set_cannons(level):
	var width_1 = game.LEVEL_ONE_WIDTH
	var width_2 = game.LEVEL_TWO_WIDTH
	var width_3 = game.LEVEL_THREE_WIDTH
	if(level == 1):
		hide_cannons()
		cannon_1_1.visible = true
		cannon_1_2.visible = true
		#up
		var start_cell_1_1 = Vector2i(0, 0)
		#down
		var start_cell_1_2 = Vector2i((width_1-1)*game.TILE_SIZE, (width_1+1)*game.TILE_SIZE)
		cannon_1_1.global_position = start_cell_1_1 + Vector2i(game.TILE_SIZE/2, -game.TILE_SIZE/2)
		cannon_1_2.global_position = start_cell_1_2 + Vector2i(game.TILE_SIZE/2, -game.TILE_SIZE/2)
	if(level == 2):
		hide_cannons()
		cannon_2_1.visible = true
		cannon_2_2.visible = true
		cannon_2_3.visible = true
		cannon_2_4.visible = true
		#up
		var start_cell_2_1 = Vector2i((width_2-1)/2*game.TILE_SIZE, 0)
		#down
		var start_cell_2_2 = Vector2i((width_2-1)/2*game.TILE_SIZE, (width_2+1)*game.TILE_SIZE)
		#left
		var start_cell_2_3 = Vector2i(-1*game.TILE_SIZE, (width_2+1)/2*game.TILE_SIZE)
		#right
		var start_cell_2_4 = Vector2i((width_2)*game.TILE_SIZE,(width_2+1)/2*game.TILE_SIZE)
		cannon_2_1.global_position = start_cell_2_1 + Vector2i(game.TILE_SIZE/2, -game.TILE_SIZE/2)
		cannon_2_2.global_position = start_cell_2_2 + Vector2i(game.TILE_SIZE/2, -game.TILE_SIZE/2)
		cannon_2_3.global_position = start_cell_2_3 + Vector2i(game.TILE_SIZE/2, -game.TILE_SIZE/2)
		cannon_2_4.global_position = start_cell_2_4 + Vector2i(game.TILE_SIZE/2, -game.TILE_SIZE/2)
	if(level == 3):
		hide_cannons()
		cannon_3_1.visible = true
		cannon_3_2.visible = true
		cannon_3_3.visible = true
		cannon_3_4.visible = true
		cannon_3_5.visible = true
		cannon_3_6.visible = true
		cannon_3_7.visible = true
		cannon_3_8.visible = true
		#up
		var start_cell_3_1 = Vector2i(((width_3-1)/2+2)*game.TILE_SIZE, 0)
		var start_cell_3_2 = Vector2i(((width_3-1)/2-2)*game.TILE_SIZE, 0)
		#down
		var start_cell_3_3 = Vector2i(((width_3-1)/2+2)*game.TILE_SIZE, (width_3+1)*game.TILE_SIZE)
		var start_cell_3_4 = Vector2i(((width_3-1)/2-2)*game.TILE_SIZE, (width_3+1)*game.TILE_SIZE)
		#left
		var start_cell_3_5 = Vector2i(-1*game.TILE_SIZE, ((width_3+1)/2+2)*game.TILE_SIZE)
		var start_cell_3_6 = Vector2i(-1*game.TILE_SIZE, ((width_3+1)/2-2)*game.TILE_SIZE)
		#right
		var start_cell_3_7 = Vector2i((width_3)*game.TILE_SIZE, ((width_3+1)/2+2)*game.TILE_SIZE)
		var start_cell_3_8 = Vector2i((width_3)*game.TILE_SIZE, ((width_3+1)/2-2)*game.TILE_SIZE)
		cannon_3_1.global_position = start_cell_3_1 + Vector2i(game.TILE_SIZE/2, -game.TILE_SIZE/2)
		cannon_3_2.global_position = start_cell_3_2 + Vector2i(game.TILE_SIZE/2, -game.TILE_SIZE/2)
		cannon_3_3.global_position = start_cell_3_3 + Vector2i(game.TILE_SIZE/2, -game.TILE_SIZE/2)
		cannon_3_4.global_position = start_cell_3_4 + Vector2i(game.TILE_SIZE/2, -game.TILE_SIZE/2)
		cannon_3_5.global_position = start_cell_3_5 + Vector2i(game.TILE_SIZE/2, -game.TILE_SIZE/2)
		cannon_3_6.global_position = start_cell_3_6 + Vector2i(game.TILE_SIZE/2, -game.TILE_SIZE/2)
		cannon_3_7.global_position = start_cell_3_7 + Vector2i(game.TILE_SIZE/2, -game.TILE_SIZE/2)
		cannon_3_8.global_position = start_cell_3_8 + Vector2i(game.TILE_SIZE/2, -game.TILE_SIZE/2)
