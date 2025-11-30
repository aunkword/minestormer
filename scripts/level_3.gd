extends Node2D

@onready var blanks_3: TileMapLayer = %Blanks3
@onready var tiles_3: TileMapLayer = %Tiles3
@onready var cover_3: TileMapLayer = %Cover3
@onready var flags_3: TileMapLayer = %Flags3
@onready var borders_3: TileMapLayer = %Borders3
#@onready var cannon_2_1: Node2D = %Cannon2_1
#@onready var cannon_2_2: Node2D = %Cannon2_2
@onready var player: CharacterBody2D = $"../Player/Player"

func level_3_clear():
	# clearing
	blanks_3.clear()
	tiles_3.clear()
	cover_3.clear()
	flags_3.clear()
	borders_3.clear()

func level_3_lay():
	# laying
	blanks_3.lay_blanks(3)
	tiles_3.lay_tiles(3)
	cover_3.lay_cover(3)
	borders_3.lay_borders(3)
	player.change_pos()
