extends Node2D

var endptsTmp = []
var endDist = {}
var endObjects = {}
var points = []
var angles = []
var r1 = 0
var r
var color
var colorOffset = 5
var deltaTime = 0

func _ready():
	start(Vector2(200, 200), 100)
	#_draw()
	
	
func start(pos, size):
	position = pos
	r = size
	color = Color(r * colorOffset, r * colorOffset, r * colorOffset)
	getEndCircle()
	print(endptsTmp.size())
	
	var angDif = 360.0/endptsTmp.size()
	var angle
	
	print(angDif)
	
	# Get wave end points and collided walls
	for i in range(endptsTmp.size()):
		angle = i * angDif
		$Ray.cast_to = endptsTmp[i]
		angles.push_back(angle)
		if $Ray.is_colliding():
			endDist[angle] = sqrt(pow($Ray.get_collision_point().x-position.x, 2) + pow($Ray.get_collision_point().y-position.y, 2))
			endObjects[angle] = $Ray.get_collider()
		else:
			endDist[angle] = sqrt(pow(endptsTmp[i].x-position.x, 2) + pow(endptsTmp[i].y-position.y, 2))
			endObjects[angle] = null
	
	# enpoints don't exactly match the angles

	

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
		
		endptsTmp.push_back(Vector2(position.x + x, position.y + y))
		endptsTmp.push_back(Vector2(position.x - x, position.y + y))
		endptsTmp.push_back(Vector2(position.x + x, position.y - y))
		endptsTmp.push_back(Vector2(position.x - x, position.y - y))
		endptsTmp.push_back(Vector2(position.x + y, position.y + x))
		endptsTmp.push_back(Vector2(position.x - y, position.y + x))
		endptsTmp.push_back(Vector2(position.x + y, position.y - x))
		endptsTmp.push_back(Vector2(position.x - y, position.y - x))
		
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
	var pos
	var spd
	deltaTime += delta
	#print(deltaTime)
	if r-r1 < 10:
		spd = 0.05
	else:
		spd = 0.02
	if deltaTime >= spd:
		deltaTime -= spd
		points.clear()
		r1 += 1
		for i in angles:
			pos = getPoint(i, r1)
			
			if r1 >= endDist[i]:

				if endObjects[i] != null:
					endObjects[i].setIntensity(r1/r)
				angles.erase(i)
				endObjects.erase(i)
				endDist.erase(i)
			else:
				points.push_back(pos)
	update()
			
			
		
	#start(Vector2(200, 200), r + 100*delta)
	#update()
	#pass


#func _on_SoundAdvanceTimer_timeout():

func _draw():
	#print(points.size())
	for i in points:
		draw_primitive([i], [color], PoolVector2Array( ))
