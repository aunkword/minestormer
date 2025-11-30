extends Node2D

@onready var blanks_1: TileMapLayer = %Blanks1
@onready var tiles_1: TileMapLayer = %Tiles1
@onready var cover_1: TileMapLayer = %Cover1
@onready var flags_1: TileMapLayer = %Flags1
@onready var borders_1: TileMapLayer = %Borders1
@onready var player: CharacterBody2D = $"../Player/Player"

func level_1_clear():
	# clearing
	blanks_1.clear()
	tiles_1.clear()
	cover_1.clear()
	flags_1.clear()
	borders_1.clear()

func level_1_lay():
	# laying
	blanks_1.lay_blanks(1)
	tiles_1.lay_tiles(1)
	cover_1.lay_cover(1)
	borders_1.lay_borders(1)
	player.change_pos()
