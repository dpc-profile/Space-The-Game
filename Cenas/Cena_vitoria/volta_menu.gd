extends Button

export (Color, RGB) var mouse_fora
export (Color, RGB) var mouse_dentro

func _on_Button_mouse_entered():
	get_node("/root/menu_musica/Som_botoes").play()
#muda a cor	
	set_modulate(mouse_dentro)
#muda o tamanho	
	set_scale(Vector2(1,1))



func _on_Button_mouse_exited():
#muda a cor	
	set_modulate(mouse_fora)
#muda o tamanho	
	set_scale(Vector2(1,1))
	pass # Replace with function body.
