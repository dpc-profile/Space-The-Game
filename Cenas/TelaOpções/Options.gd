extends Control

func _ready():
	#Botões do menu
	$btn_video.connect("pressed", self, "Video")
	$btn_audio.connect("pressed",self, "Audio")
	$btn_volta.connect("pressed",self,"Voltar")	
	#Botões de resolução
	$Cntrl_video/btn_resulucao.connect("item_selected",self, "Resolution")
	$Cntrl_video/btn_fullscreen.connect("item_selected",self, "Fullscreen")
	#Opções de resolução de tela
	$Cntrl_video/btn_resulucao.add_item("1024 x 600", 0)
	$Cntrl_video/btn_resulucao.add_item("1920 x 1080", 1)
	$Cntrl_video/btn_fullscreen.add_item("Modo janela", 0)
	$Cntrl_video/btn_fullscreen.add_item("Tela cheia", 1)
	
	$Cntrl_video.show()
	$Cntrl_audio.hide()
	
	
	#Pega o tamanho da tela e seleciona o botão que corresponde o numero
	if(menu_musica.res_largura == 1024 and menu_musica.res_altura == 600):
		$Cntrl_video/btn_resulucao.select(0)
	elif(menu_musica.res_largura == 1920 and menu_musica.res_altura == 1080):
		$Cntrl_video/btn_resulucao.select(1)
		
	if(menu_musica.fullscreen == false):
		$Cntrl_video/btn_resulucao.select(0)
	elif(menu_musica.fullscreen == true):
		$Cntrl_video/btn_resulucao.select(1)	


func Video():
	$Cntrl_video.show()
	$Cntrl_audio.hide()
	
func Audio():
	$Cntrl_video.hide()
	$Cntrl_audio.show()

func Voltar():
	get_tree().change_scene("res://Cenas/TelaMenu/TitleScream.tscn")


func Resolution(item):
	match item:
		0:
			menu_musica.res_largura = 1024
			menu_musica.res_altura = 600
			menu_musica.resolucao() 
		1:
			menu_musica.res_largura = 1920
			menu_musica.res_altura = 1080
			menu_musica.resolucao() 

func Fullscreen(item):	
	match item:
		0:
			menu_musica.fullscreen = false
			menu_musica.resolucao()
		1:
			menu_musica.fullscreen = true
			menu_musica.resolucao()


#volume da musica
func _on_sldr_musica_value_changed(value):
	AudioServer.set_bus_volume_db(1, value)
	if value == -34:
		AudioServer.set_bus_mute(1,true)
	else: 
		AudioServer.set_bus_mute(1,false)
