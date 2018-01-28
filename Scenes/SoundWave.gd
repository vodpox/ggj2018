extends Node2D

var endptsTmp = []
var endDist = {}
var endObjects = {}
var points = []
var angles = []
var r1 = 0
var r = 0
var color
var deltaTime = 0
var ptsDict = {}

func _ready():
	start(Vector2(200, 200), 100)
	
	
func start(pos, size):
	#getEndCircle(4)
	#print(endptsTmp)
	
	
	position = pos
	r = size
	#color = Color(r/300.0, r/300.0, r/300.0)
	
	var angDif = 360.0/(r*8)
	var angle
	
	# Get wave end points and collided walls
	for i in range(r*8):
		angle = i * angDif
		$Ray.cast_to = getPoint(angle, r)
		$Ray.force_raycast_update()
		angles.push_back(angle)
		if $Ray.is_colliding():
			endDist[angle] = sqrt(pow($Ray.get_collision_point().x-position.x, 2) + pow($Ray.get_collision_point().y-position.y, 2))
			endObjects[angle] = $Ray.get_collider()
		else:
			endDist[angle] = r
			endObjects[angle] = null
	

func getPoint(angle, distance):
	var x = distance * cos(deg2rad(angle))
	var y = distance * sin(deg2rad(angle))
	return Vector2(x, y)

func _physics_process(delta):
	if r == 0:
		return
	if angles.size() == 0:
		queue_free()
		return
	var col = float(r-r1)/r*(r/100.0)  # /r
	var colOff = 0.2
	var spd = 0.002
	var point
	#deltaTime += delta

	#if deltaTime >= spd:
	#	deltaTime -= spd
	ptsDict.clear()
	color = Color(col+colOff, col+colOff, col+colOff)
	r1 += 1
	for i in angles:
		#if !endDist.has(i):
		#	continue
		if r1 >= endDist[i]:
			if endObjects[i] != null:
				endObjects[i].setIntensity(col)
			#endObjects.erase(i)
			#endDist.erase(i)
			angles.erase(i)
		else:
			point = getPoint(i, r1)
			if !ptsDict.has(point):
				ptsDict[point] = 0
			#points.push_back(point)
	update()


func _draw():
	for i in ptsDict.keys():
		draw_primitive([i], [color], PoolVector2Array( ))
		
		
func getEndCircle(r):
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