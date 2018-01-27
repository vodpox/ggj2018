extends Node2D


var endpoints = []
var endObjects = []
var points = []
var angles = []
var r1 = 0
var r
var color
var colorOffset = 5

func _ready():
	start(Vector2(200, 200), 2)
	#_draw()
	
	
func start(pos, size):
	position = pos
	r = size
	color = Color(r * colorOffset, r * colorOffset, r * colorOffset)
	getEndCircle()
	
	for i in range(endpoints.size()):
		$Ray.cast_to = endpoints[i]
		if $Ray.is_colliding():
			endpoints[i] = $Ray.get_collision_point()
			endObjects.push_back($Ray.get_collider())
		else:
			endpoints[i] = Vector2()
			endObjects.push_front(null)
	

func getEndCircle():
	#draw_primitive([Vector2(position.x, position.y)], [color], PoolVector2Array( ))
	var x = r - 1
	var y = 0
	var dx = 1
	var dy = 1
	var err = dx - r*2
	
	while x >= y:
		"""
		draw_primitive([Vector2(position.x + x, position.y + y)], [color], PoolVector2Array( ))
		draw_primitive([Vector2(position.x - x, position.y + y)], [color], PoolVector2Array( ))
		draw_primitive([Vector2(position.x + x, position.y - y)], [color], PoolVector2Array( ))
		draw_primitive([Vector2(position.x - x, position.y - y)], [color], PoolVector2Array( ))
		draw_primitive([Vector2(position.x + y, position.y + x)], [color], PoolVector2Array( ))
		draw_primitive([Vector2(position.x - y, position.y + x)], [color], PoolVector2Array( ))
		draw_primitive([Vector2(position.x + y, position.y - x)], [color], PoolVector2Array( ))
		draw_primitive([Vector2(position.x - y, position.y - x)], [color], PoolVector2Array( ))
		"""
		
		endpoints.push_back(Vector2(position.x + x, position.y + y))
		endpoints.push_back(Vector2(position.x - x, position.y + y))
		endpoints.push_back(Vector2(position.x + x, position.y - y))
		endpoints.push_back(Vector2(position.x - x, position.y - y))
		endpoints.push_back(Vector2(position.x + y, position.y + x))
		endpoints.push_back(Vector2(position.x - y, position.y + x))
		endpoints.push_back(Vector2(position.x + y, position.y - x))
		endpoints.push_back(Vector2(position.x - y, position.y - x))
		
		if err <= 0:
			y += 1
			err += dy
			dy += 2
		else:
			x -= 1
			dx += 2
			err += dx - r*2


func getPoint(angle, distance):
	var x = distance * cos(deg2rad(angle))
	var y = distance * sin(deg2rad(angle))
	return Vector2(x, y)
	

func end():
	queue_free()
	
func _process(delta):
	start(Vector2(200, 200), r + 100*delta)
	update()


#func _on_SoundAdvanceTimer_timeout():

