extends KinematicBody2D


export (int) var speed
export (int) var maxHealth
export (PackedScene) var soundWave
export (int) var shootVolume
export (int) var hitVolume
var health
var isReloaded = true
var velocity = Vector2()



func _ready():
	#call_deferred("set_monitoring", false)
	#hide()
	pass


func _process(delta):
	
	if Input.is_action_pressed("shoot"):
		if isReloaded:
			shoot()
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed * delta
		move_and_collide(velocity)
	
	rotation = position.angle_to_point(get_viewport().get_mouse_position()) + PI
	
	velocity.x = 0
	velocity.y = 0


func shoot():
	
	var shootWave = soundWave.instance();
	get_parent().add_child(shootWave);
	shootWave.start(position, shootVolume)
	
	if $BulletRay.is_colliding():
		
		var hitWave = soundWave.instance();
		get_parent().add_child(hitWave);
		hitWave.start($BulletRay.get_collision_point(), hitVolume)
	
	isReloaded = false
	$ReloadTimer.start()


func _on_ReloadTimer_timeout():
	isReloaded = true


func spawn(pos):
	position = pos
	#monitoring = true
	health = maxHealth
	show()
	#monitoring = true



func die():
	call_deferred("set_monitoring", false)
	hide()


