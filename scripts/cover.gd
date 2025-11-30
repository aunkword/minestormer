extends TileMapLayer

@onready var game: Node2D = $"../.."
@onready var tiles_1: TileMapLayer = %Tiles1
@onready var tiles_2: TileMapLayer = %Tiles2
@onready var tiles_3: TileMapLayer = %Tiles3

# atlas coords - sourceID = 1
var tile_atlas := Vector2i(0,0)

func lay_cover(level):
	var width = game.get_width(level)
	var center_square = Vector2i(width/2,width/2)
	var center_nine
	if level == 1:
		center_nine = tiles_1.get_all_surrounding_cells(center_square, width)
	if level == 2:
		center_nine = tiles_2.get_all_surrounding_cells(center_square, width)
	if level == 3:
		center_nine = tiles_3.get_all_surrounding_cells(center_square, width)

	center_nine.append(center_square)
	# get empty cells
	for i in range(width):
		for j in range(width):
			var pos = Vector2i(i, j)
			if pos in center_nine:
				continue
			# set empty sell to cover tile
			set_cell(pos, 1, tile_atlas)
