extends Node2D
onready var timer = get_node("Timer")
var segundos = 3
var tempo_seg = pega_tempo.pega_seg
var tempo_min = pega_tempo.pega_min

func _ready():
	$vitoria.play()
	get_node("/root/menu_musica/Musica_CTF").stop()#Para a MusicaDoMenu

#Pressionar espaço para iniciar o timer
func _process(delta):
	if(Input.is_action_just_pressed("ui_select")):
		timer.start()
	get_node("VBoxContainer/Tempo").set_text("Tempo de jogo:\n"+ str(tempo_seg)+ " Segundos\n" + str(tempo_min) + "Minutos")
	
#Sempre que o timer acaba, diminui 1 no segundos até
#entrar na condição do if e mudar de cena
func _on_Timer_timeout():
		segundos -= 1
		get_node("Contador").set_text(str(segundos))
		if segundos == -1:
			get_node("/root/menu_musica/Musica_CTF").play()
			if Global.dificuldade == "facil":
				get_tree().change_scene("res://Cenas/Map/Mapa_Captura_Bandeira.tscn")
			if Global.dificuldade == "dificil":
				get_tree().change_scene("res://Cenas/Map/Mapa_corredor.tscn")
		





func _on_Button_pressed():
	get_tree().change_scene("res://Cenas/TelaMenu/TitleScream.tscn")
	pass # Replace with function body.


