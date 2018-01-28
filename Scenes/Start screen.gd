extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var localIp = IP.get_local_addresses()
	#$HostContainer/HBoxContainer/LbIPHost.text = localIp[3]
	$HostContainer/HBoxContainer/LbIPHost.text = "127.0.1.1"
	$SettingsContainer/CheckBox.pressed=true

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Timer_timeout():
	$StartScreenMusic.play()


func _on_BtnStart_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")
	#$StartButtonContainer.visible=false
	#$MultiplayerButtonContainer.visible=true


func _on_BtnBack_pressed():
	$MultiplayerButtonContainer.visible=false
	$StartButtonContainer.visible=true


func _on_BtnBackFromHost_pressed():
	$HostContainer.visible=false
	$MultiplayerButtonContainer.visible=true


func _on_BtnStartHost_pressed():
	$MultiplayerButtonContainer.visible=false
	$HostContainer.visible=true


func _on_BtnQuit_pressed():
	get_tree().quit()


func _on_BtnBackFromSearch_pressed():
	$FindContainer.visible=false
	$MultiplayerButtonContainer.visible=true


func _on_BtnStartSearch_pressed():
	$MultiplayerButtonContainer.visible=false
	$FindContainer.visible=true


func _on_BtnHostGame_pressed():
	$StartScreenMusic.stop()
	$StartScreenMusicTimer.stop()
	#Start hosting a game
	#Go to game scene
	print("start server")
	get_node("../Lobby").createServer(int(get_node("HostContainer/HBoxContainer/LbIPHost").text))


func _on_BtnSearchGame_pressed():
	$StartScreenMusic.stop()
	$StartScreenMusicTimer.stop()
	#Start searching for a game
	#Go to game scene
	print("start guest")
	#print()
	get_node("../Lobby").joinServer(get_node("FindContainer/HBoxContainer/TEIPSearch").text, int(get_node("FindContainer/HBoxContainer/TEIPSearch").text))


func _on_BtnSettings_pressed():
	$StartButtonContainer.visible=false
	$SettingsContainer.visible=true


func _on_BtnBackFromSettings_pressed():
	$SettingsContainer.visible=false
	$StartButtonContainer.visible=true


func _on_CheckBox_pressed():
	if($SettingsContainer/CheckBox.pressed==false):
		$StartScreenMusic.stop()
		$StartScreenMusicTimer.stop()
	else:
		$StartScreenMusic.play()
		$StartScreenMusicTimer.start()


func _on_BtnBackFromCredits_pressed():
	$CreditsContainer.visible=false
	$StartButtonContainer.visible=true


func _on_BtnCredits_pressed():
	$StartButtonContainer.visible=false
	$CreditsContainer.visible=true
