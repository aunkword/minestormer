extends TileMapLayer

@onready var game: Node2D = $"../.."

# atlas coords - source = 1
var one_atlas := Vector2i(1,0)
var two_atlas := Vector2i(2,0)
var three_atlas := Vector2i(0,1)
var four_atlas := Vector2i(1,1)
var five_atlas := Vector2i(2,1)
var six_atlas := Vector2i(0,2)
var seven_atlas := Vector2i(1,2)
var eight_atlas := Vector2i(2,2)

# atlas coords - source = 0
var mine_atlas := Vector2i(0,1)

# arrays for mine coords
var mine_coords_1 := []
var mine_coords_2 := []
var mine_coords_3 := []

func lay_tiles(level):
	var mine_coords
	var width = game.get_width(level)
	var mines = game.get_total_mines(level)
	if level == 1:
		mine_coords = mine_coords_1
	if level == 2:
		mine_coords = mine_coords_2
	if level == 3:
		mine_coords = mine_coords_3
	# clear tilemap
	mine_coords.clear()
	generate_mines(width, mine_coords, mines)
	generate_numbers(width, level)

func generate_mines(width, mine_coords, mines):
	# getting the 9 center squares
	var center_square = Vector2i(width/2,width/2)
	var center_nine = get_all_surrounding_cells(center_square, width)
	center_nine.append(center_square)
	
	while mine_coords.size() < mines:
		var mine_pos = Vector2i(randi_range(0, width-1), randi_range(0, width-1))
		# checks if already exists or is in 9 center squares
		if mine_pos in mine_coords or mine_pos in center_nine:
			continue
		# if it doesn't exist, generate mine
		mine_coords.append(mine_pos)
		set_cell(mine_pos, 0, mine_atlas)

func generate_numbers(width, level):
	# get empty cells
	for i in get_empty_cells(width, level):
		var mine_count : int = 0
		# iterate through empty cells and get all surrounding cells
		for j in get_all_surrounding_cells(i, width):
		# add up number of mines inside surrounding cells
			if is_mine(j, level):
				mine_count += 1
		if mine_count == 1:
			set_cell(i, 1, one_atlas)
		elif mine_count == 2:
			set_cell(i, 1, two_atlas)
		elif mine_count == 3:
			set_cell(i, 1, three_atlas)
		elif mine_count == 4:
			set_cell(i, 1, four_atlas)
		elif mine_count == 5:
			set_cell(i, 1, five_atlas)
		elif mine_count == 6:
			set_cell(i, 1, six_atlas)
		elif mine_count == 7:
			set_cell(i, 1, seven_atlas)
		elif mine_count == 8:
			set_cell(i, 1, eight_atlas)

func get_empty_cells(width, level):
	var empty_cells := []
	for i in range(width):
		for j in range(width):
			# check if cell is empty and add to array
			var pos = Vector2i(j, i)
			if !is_mine(pos, level):
				empty_cells.append(pos)
	return empty_cells

func get_all_surrounding_cells(middle_cell, width):
	var surrounding_cells := []
	var target_cell
	for i in range(3):
		for j in range(3):
			target_cell = middle_cell + Vector2i(i-1, j-1)
			# skip cell if it's the middle one
			if target_cell != middle_cell:
				# check that cell is on the grid
				if(target_cell.x >= 0 and target_cell.x <= width - 1
				and target_cell.y >= 0 and target_cell.y <= width -1):
					surrounding_cells.append(target_cell)
	return surrounding_cells

# helper functions
func is_mine(pos: Vector2i, level):
	if level == 1:
		return is_mine_1(pos)
	if level == 2:
		return is_mine_2(pos)
	if level == 3:
		return is_mine_3(pos)
func is_mine_1(pos: Vector2i):
	return pos in mine_coords_1
func is_mine_2(pos: Vector2i):
	return pos in mine_coords_2
func is_mine_3(pos: Vector2i):
	return pos in mine_coords_3
func is_blank(pos):
	return get_cell_source_id(pos) == -1
