extends Node2D


var circleRadii = []
var circleColor = 1.0

var dist = 200
var insert = true
var done = false

var checkedWalls = {}


func _ready():
	$CollisionShape2D.shape.radius = 2
	set_physics_process(true)


func start(pos, r):
	dist = r
	position = pos

func _physics_process(delta):
	if insert:
		position.x += 1
	else:
		position.x -= 1
	
	if insert:
		if !done:
			if circleRadii.size() < dist/5:
				circleRadii.push_back(1)
			else:
				done = true
		insert = false
	else:
		insert = true

	var i = 0
	while i < circleRadii.size():
		circleRadii[i] += 2
		if circleRadii[i] >= dist:
			circleRadii.pop_front()
			i -= 1
		i += 1
	circleColor -= 2.0/dist
	update()
	
	if $CollisionShape2D.shape.radius < dist:
		$CollisionShape2D.shape.radius += 2

	
	if circleColor <= 0.1:
		#print("done")
		queue_free()


func _draw():
	#draw_circle(position, dist, Color(1, 0, 0))
	var col
	for i in range(circleRadii.size()):
		col = circleColor-float(i)/(dist/5) + 0.1
		draw_circle(Vector2(), circleRadii[i], Color(col, col, col))
	

func _on_collision( area ):
	if !area.is_in_group("Walls"):
		return
	#print("collided")
	if checkedWalls.has(area.position):
		return
		
	area.setIntensity(circleColor)
	checkedWalls[area.position] = 0
