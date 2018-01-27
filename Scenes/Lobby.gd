extends Node


func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")


func _player_connected(id):
	
	if get_tree().get_network_unique_id() == 1:
		pass
	


func _player_disconnected(id):
	player_info.erase(id) # Erase player from info


func _connected_ok():
	pass


func _server_disconnected():
	#TODO: show error
	pass


func _connected_fail():
	#TODO: show error
	pass