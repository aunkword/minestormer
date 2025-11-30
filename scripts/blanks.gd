extends TileMapLayer

## THIS FILE IS DONE DO NOT TOUCH
## CONTAINS METHODS FOR LAYING BLANKS FOR ALL 3 LEVELS

@onready var game: Node2D = $"../.."

# atlas coords - source = 0
var blank_tile_atlas := Vector2i(0,0)

func lay_blanks(level):
	var width = game.get_width(level)

	for i in range(width):
		for j in range(width):
			var pos = Vector2(i,j)
			if get_cell_source_id(pos) == -1:
				set_cell(pos, 0, blank_tile_atlas)
