extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)


func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		$DisconnectBackground.visible = true
		$DisconnectBackground/DisconectTimer.start()

func _on_DisconectTimer_timeout():
	$DisconnectBackground.visible = false
	get_tree().change_scene("res://Scenes/Start screen.tscn")