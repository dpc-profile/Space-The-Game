extends KinematicBody2D
#class_name Mob

var cena_bala = preload("res://Cenas/tiroTorre.tscn")
var mov = Vector2(0,0)
var velx = 60
var dentro_area = false

var minimap_icon="mob"

func _ready():
	dentro_area = false

func _process(delta):
	
	if Global.player_global_pos != null:
		look_at(Global.player_global_pos)


func _on_Timer_timeout():
	if dentro_area:
		disparar()


func _on_Area2D_body_entered(body):
	if body.is_in_group("player1"):	
		dentro_area = true

func _on_Area2D_body_exited(body):
	dentro_area  = false
	
func disparar():
	var bala = cena_bala.instance()
	bala.global_position = $bullet_point_enemy.global_position
	bala.rotation = rotation
	get_tree().root.add_child(bala)

func recebendo_dano(damage):
	return
	
