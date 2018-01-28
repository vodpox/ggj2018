extends Node

export (PackedScene) var gameScene
export (PackedScene) var player
var otherPlayerID
var myID


func createServer(port):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(330, 1)
	get_tree().set_network_peer(peer)


func joinServer(ip, port):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, port)
	get_tree().set_network_peer(peer)


sync func disconnect(disconnectingID):
	
	if disconnectingID == otherPlayerID:
		#show error
		pass
	else:
		#go to menu
		pass
	
	get_tree().set_network_peer(null) # TODO: check if this function is still called on peer after this
	print("disconnected")


func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_ok")
	get_tree().connect("connection_failed", self, "_connected_fail")
	get_tree().connect("server_disconnected", self, "_server_disconnected")


func _player_connected(id):
	myID = get_tree().get_network_unique_id()
	otherPlayerID = id
	
	#TODO: load level + pause, wait for ok from guest, unpause
	
	#game scene
	var gameInstance = load(gameScene).instance()
	get_node("/root").add_child(gameInstance)
	
	#player
	var my_player = load(player).instance() # pass true
	my_player.set_name(str(myID))
	my_player.set_network_master(myID) # Will be explained later
	get_node("/root/gameScene").add_child(my_player)
	
	#other player
	var otherPlayer = load(player).instance() # pass false
	otherPlayer.set_name(str(otherPlayerID))
	get_node("/root/gameScene").add_child(player)
	
	#get_tree().set_pause(true)
	print("connected")



func _player_disconnected(id):
	pass


func _connected_ok():
	pass


func _server_disconnected():
	#TODO: show error
	pass


func _connected_fail():
	#TODO: show error
	pass