extends Area2D
@onready var somPorta = $"../somPorta"

func interact():
	print("Kiwi interagiu com: porta do armário")
	somPorta.play()
