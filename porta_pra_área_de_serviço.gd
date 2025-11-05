extends Area2D

func interact():
	print("Saindo da sala...")
	Transição.change_scene_with_fade("res://area_de_serviço.tscn")
