extends Node

var collected 
var status
var gem = "die"
var pickable_gem
var gem_holder
var vitoria = false
var shake_screen = false
var dificuldade = ""
var map_select #Recebe qual mapa está selecionado, 1 para o mapa facil e 2 para o mapa dificil


#recebe a posição global do nave_player2
var player_global_pos

#define se a gema foi coletada ou não
func collected_gem(gem_collected):
	collected = gem_collected
	
#Faz o Kinematic Body da bandeira sumir
func kill_gem_body():
	 status = gem
	
#define se a bandeira pode ser coletada
func ellegible_pickable(pickable):
	pickable_gem = pickable

func ganhou(verificar):
	vitoria = verificar

