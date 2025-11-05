extends Node2D

@onready var player = $kiwi
@onready var light = $PointLight2D
	
func _process(delta):
	if Input.is_action_just_pressed("toggle_light"):
		alternar_lanterna()
		
	var alvo = player.global_position
	light.global_position = light.global_position.lerp(alvo, 5 * delta)

func alternar_lanterna():
	$PointLight2D.enabled = not $PointLight2D.enabled

func _on_troca_de_cena_body_entered(body):
	if body.name == "kiwi":
		print("Kiwi entrou no corredor da escada")
		TransiçãoCorredor.change_scene_with_fade("res://escada.tscn")
