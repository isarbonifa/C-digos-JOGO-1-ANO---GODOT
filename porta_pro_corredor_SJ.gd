extends Area2D

func interact():
	print("Kiwi entrou no corredor da escada")
	Transição.change_scene_with_fade("res://escada.tscn")
