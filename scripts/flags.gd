extends TileMapLayer

# atlas coords - sourceID = 0
var flag_atlas := Vector2i(0,0)

func place_flag(tile_pos: Vector2i):
	set_cell(tile_pos, 3, flag_atlas)

func remove_flag(tile_pos: Vector2i):
	erase_cell(tile_pos)

func has_flag(tile_pos: Vector2i):
	return get_cell_source_id(tile_pos) != -1
