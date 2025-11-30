extends Node2D

@onready var blanks_2: TileMapLayer = %Blanks2
@onready var tiles_2: TileMapLayer = %Tiles2
@onready var cover_2: TileMapLayer = %Cover2
@onready var flags_2: TileMapLayer = %Flags2
@onready var borders_2: TileMapLayer = %Borders2
#@onready var cannon_2_1: Node2D = %Cannon2_1
#@onready var cannon_2_2: Node2D = %Cannon2_2
@onready var player: CharacterBody2D = $"../Player/Player"

func level_2_clear():
	# clearing
	blanks_2.clear()
	tiles_2.clear()
	cover_2.clear()
	flags_2.clear()
	borders_2.clear()

func level_2_lay():
	# laying
	blanks_2.lay_blanks(2)
	tiles_2.lay_tiles(2)
	cover_2.lay_cover(2)
	borders_2.lay_borders(2)
	player.change_pos()
