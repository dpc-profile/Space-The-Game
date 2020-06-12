extends Node

const DEFAULT_IP = '192.168.0.3'
const DEFAULT_PORT = 49675
const MAX_PLAYERS = 6

var conexao = [DEFAULT_IP, DEFAULT_PORT]
var MULTIPLAYER_ON = false
var players = { }
var self_data = { name = '', position = Vector2(0, 0)}

signal player_disconnected
signal server_disconnected

func _ready():
	get_tree().connect('network_peer_disconnected', self, '_on_player_disconnected')
	get_tree().connect('network_peer_connected', self, '_on_player_connected')

func create_server(player_nickname):
	self_data.name = player_nickname
	players[0] = self_data
	var peer = NetworkedMultiplayerENet.new()
	
	if conexao[1] != Network.DEFAULT_PORT:
		peer.create_server(conexao[1], MAX_PLAYERS)
	else:	
		peer.create_server(DEFAULT_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)

func connect_to_server(player_nickname):
	self_data.name = player_nickname
	get_tree().connect('connected_to_server', self, '_connected_to_server')
	var peer = NetworkedMultiplayerENet.new()
	if conexao[0] != Network.DEFAULT_IP:
		peer.create_client(conexao[0], DEFAULT_PORT)
	else:
		peer.create_client(DEFAULT_IP, DEFAULT_PORT)
	get_tree().set_network_peer(peer)

func _connected_to_server():
	var local_player_id = get_tree().get_network_unique_id()
	players[local_player_id] = self_data
	rpc('_send_player_info', local_player_id, self_data)

func _on_player_disconnected(id):
	players.erase(id)

func _on_player_connected(connected_player_id):
	var local_player_id = get_tree().get_network_unique_id()
	if not(get_tree().is_network_server()):
		rpc_id(1, '_request_player_info', local_player_id, connected_player_id)

remote func _request_player_info(request_from_id, player_id):
	if get_tree().is_network_server():
		rpc_id(request_from_id, '_send_player_info', player_id, players[player_id])

# A function to be used if needed. The purpose is to request all players in the current session.
remote func _request_players(request_from_id):
	if get_tree().is_network_server():
		for peer_id in players:
			if( peer_id != request_from_id):
				rpc_id(request_from_id, '_send_player_info', peer_id, players[peer_id])

remote func _send_player_info(id, info):
	players[id] = info
	var new_player = load('res://Cenas/nave_player2.tscn').instance()
	new_player.name = str(id)
	new_player.set_network_master(id)
	$'/root/Cena/Mapa_Captura_Bandeira/'.add_child(new_player)
	new_player.init(info.name, info.position, false)

func update_position(id, position):
	players[id].position = position
