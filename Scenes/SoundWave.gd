extends Node2D

var endptsTmp = []
var endDist = {}
var endObjects = {}
var points = []
var angles = []
var r1 = 0
var r = 0
var color
var colorOffset = 5
var deltaTime = 0

func _ready():
	$Timer.start()
	#_draw()
	
	
func start(pos, size):
	"""
	for i in range(1, 200):
		r = i
		getEndCircle()
		print(str(endptsTmp.size()))
		endptsTmp.clear()
	"""
	
	position = pos
	r = size
	color = Color(r * colorOffset, r * colorOffset, r * colorOffset)
	#getEndCircle()
	
	var angDif = 360.0/(r*8)  #/endptsTmp.size()
	var angle
	
	print(angDif)
	
	# Get wave end points and collided walls
	for i in range(r*8):
		angle = i * angDif
		$Ray.cast_to = getPoint(angle, r)#endptsTmp[i]
		$Ray.force_raycast_update()
		angles.push_back(angle)
		if $Ray.is_colliding():
			#print("yep " + str(angle))
			endDist[angle] = sqrt(pow($Ray.get_collision_point().x-position.x, 2) + pow($Ray.get_collision_point().y-position.y, 2))
			endObjects[angle] = $Ray.get_collider()
		else:
			endDist[angle] = r #sqrt(pow(endptsTmp[i].x-position.x, 2) + pow(endptsTmp[i].y-position.y, 2))
			endObjects[angle] = null
	
	# enpoints don't exactly match the angles
	

func getEndCircle():
	var x = r - 1
	var y = 0
	var dx = 1
	var dy = 1
	var err = dx - r*2
	var vec = Vector2()
	var dirs
	var vecs = {}
	
	while x >= y:
		dirs = [[x, y], [-x, y], [x, -y], [-x, -y], [y, x], [-y, x], [y, -x], [-y, -x]]
		for i in dirs:
			vec = Vector2(position.x + i[0], position.y + i[1])
			if !vecs.has(vec):
				vecs[vec] = 0
				endptsTmp.push_back(vec)

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
	if r == 0:
		return
	if angles.size() == 0:
		end()
		return
	#var col = float(r-r1)/r
	var col = 1.0-((1.0/r)*5)
	var spd = 0.01
	deltaTime += delta

	if deltaTime >= spd:
		deltaTime -= spd
		points.clear()
		#color = Color(col, col, col)
		#color *= 1.0-((1.0/r)*6)
		color *= col
		#print(1.0-(1.0/r))
		r1 += 1
		for i in angles:
			
			if r1 >= endDist[i]:
				if endObjects[i] != null:
					endObjects[i].setIntensity(float(r-r1)/r)
				angles.erase(i)
				endObjects.erase(i)
				endDist.erase(i)
			else:
				points.push_back(getPoint(i, r1))
	update()



func _draw():
	for i in points:
		draw_primitive([i], [color], PoolVector2Array( ))


func _on_Timer_timeout():
	start(Vector2(200, 200), 100)
