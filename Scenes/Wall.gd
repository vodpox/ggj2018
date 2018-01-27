extends Area2D

var RGB_r = 0
var RGB_g = 0
var RGB_b = 0

func _ready():
    # Create a timer node
    var timer = Timer.new()

    # Set timer interval
    timer.set_wait_time(1.0)

    # Set it as repeat
    timer.set_one_shot(false)

    # Connect its timeout signal to the function you want to repeat
    timer.connect("timeout", self, "repeat_me")

    # Add to the tree as child of the current node
    add_child(timer)

    timer.start()


func repeat_me():
	RGB_r += 10
	RGB_g += 10
	RGB_b += 10
	$Sprite.set_modulate(Color(RGB_r, RGB_g, RGB_b))
	print("Loop")

func _on_WallTimer_timeout():
	RGB_r += 10
	RGB_g += 10
	RGB_b += 10
	$Sprite.set_modulate(Color(RGB_r, RGB_g, RGB_b))
	$WallTimer.stop()
	$WallTimer.start()
