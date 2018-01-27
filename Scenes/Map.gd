extends TileMap

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2

enum ENTITY_TYPES {PLAYER, OBSTACLE, COLLECTIBLE}

var grid_size = Vector2(408, 408)
var grid = []

onready var Obstacle = preload("res://Wall.tscn")

var type 

func _ready():
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	
	var positions = []
	
	for il1 in range(grid_size.x):
		for stor in range(6):
			var grid_pos = Vector2(il1, stor)
			if not grid_pos in positions:
				positions.append(grid_pos)
	
	for il2 in range(grid_size.x):
		for stor in range(6):
			var grid_pos = Vector2(il2, grid_size.y-stor-1)
			if not grid_pos in positions:
				positions.append(grid_pos)
	
	for au1 in range(grid_size.y):
		for stor in range(6):
			var grid_pos = Vector2(stor, au1)
			if not grid_pos in positions:
				positions.append(grid_pos)
	
	for au2 in range(grid_size.y):
		for stor in range(6):
			var grid_pos = Vector2(grid_size.x-stor-1, au2)
			if not grid_pos in positions:
				positions.append(grid_pos)
	
	for n in range(100):
		var placed = false
		var kubas1
		var kubas2
		while not placed:
			var z = randi() % int(grid_size.x)
			var w = randi() % int(grid_size.y)
			if z%6==0:
				kubas1 = 0
			elif z%6==1:
				kubas1 = 1
			elif z%6==2:
				kubas1 = 2
			elif z%6==3:
				kubas1 = 3
			elif z%6==4:
				kubas1 = 4
			else:
				kubas1 = 5
			
			if w%6==0:
				kubas2 = 0
			elif w%6==1:
				kubas2 = 1
			elif w%6==2:
				kubas2 = 2
			elif w%6==3:
				kubas2 = 3
			elif w%6==4:
				kubas2 = 4
			else:
				kubas2 = 5
				
			for stor1 in range(6):
				for stor2 in range(6):
					var grid_pos = Vector2(z+stor1-kubas1, w+stor2-kubas2)
					if not grid_pos in positions:
						positions.append(grid_pos)
						placed = true

	for pos in positions:
		var new_obstacle = Obstacle.instance()
		new_obstacle.translate(map_to_world(pos) + half_tile_size)
		#grid[pos.x][pos.y] = OBSTACLE
		add_child(new_obstacle)

#func is_cell_vacant(pos, directions):
#	var grid_pos = world_to_map(pos) + direction
#	
#	if grid_pos.x < grid_size.x and grid_pos.x>=0:
#		if grid_pos.y < grid_size.y and grid_pos.y>=0:
#			return true if grid[grid_pos.x][grid_pos.y] == null else false
#	return false


#func update_child_pos(child_node):
#	var grid_pos = world_to_map(child_node.get_pos())
#	print(grid_pos)
#	grid[grid_pos.x][grid_pos.y] = null
#	
#	var new_grid_pos = grid_pos + child_node.direction
#	grid[new_grid_pos.x][ne_grid_pos.y] = child_node.type
#	
#	var target_pos = map_to_world(new_grid_pos) + half_tile_size
#	return target_pos
