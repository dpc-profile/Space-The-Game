extends Area2D

func _process(delta):
	translate(Vector2(4,0))


#func _on_Area2D_bala_acerta(body):
#	body.get_parent().get_node("ProgressBar").value -= 20
#	queue_free()