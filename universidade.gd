extends Node2D

# Lista de falas
var dialogos = [
	{"personagem": "Fiuza", "fala": "Eai, kiwi, estudou pra prova de mat?"},
	{"personagem": "Kiwi", "fala": "Só estuda quem precisa e eu vou tirar 10"},
	{"personagem": "Fiuza", "fala": "Oloko, tá bom então, sabichão"},
	{"personagem": "Kiwi", "fala": "Quando você já sabe fica muito chato"},
	{"personagem": "Fiuza", "fala": "Hum, sei. Mano, tô meio entendiado esses dias"},
	{"personagem": "Fiuza", "fala": "Não tem nada pra fazer nessa cidade"},
	{"personagem": "Kiwi", "fala": "Claro que tem, tava até com uma ideia"},
	{"personagem": "Fiuza", "fala": "Nem me fala, né. Qual?"},
	{"personagem": "Kiwi", "fala": "Sabe a casa Whitmore? De repende fiquei com uma vontade de ir lá"},
	{"personagem": "Fiuza", "fala": "Cê tá doido, é? Eu que não vou pra lá"},
	{"personagem": "Fiuza", "fala": "e duvido que você tenha coragem também"},
	{"personagem": "Kiwi", "fala": "Isso é um desafio?"},
	{"personagem": "Fiuza", "fala": "É, mas com uma condição."},
	{"personagem": "Fiuza", "fala": "Se você não conseguir passar a noite lá, vai me passar cola pra prova de Mat"},
	{"personagem": "Kiwi", "fala": "KKKKK beleza"}
]

var indice = 0

func _ready():
	mostrar_dialogo()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		indice += 1
		if indice < dialogos.size():
			mostrar_dialogo()
		else:
			TransiçãoCorredor.change_scene_with_fade("res://video_começo.tscn")

func mostrar_dialogo():
	var fala_atual = dialogos[indice]
	$CanvasLayer/Panel/Nome.text = fala_atual["personagem"]
	$CanvasLayer/Panel/Label.text = fala_atual["fala"]
