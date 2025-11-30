extends TileMapLayer

var border_atlas := Vector2i(0,0)

func lay_borders(level):
	var width
	if level == 1:
		width = get_parent().get_parent().LEVEL_ONE_WIDTH
	if level == 2:
		width = get_parent().get_parent().LEVEL_TWO_WIDTH
	if level == 3:
		width = get_parent().get_parent().LEVEL_THREE_WIDTH

	for i in range(12):
		for x in range(-1-i, width + i + 1):
			set_cell(Vector2i(x, -1-i), 0, border_atlas)
			set_cell(Vector2i(x, width + i), 0, border_atlas)

		# left and right borders
		for y in range(-1-i, width + i + 1):
			set_cell(Vector2i(-1-i, y), 0, border_atlas)
			set_cell(Vector2i(width + i, y), 0, border_atlas)
