extends Control

signal puzzle_resolvido
signal puzzle_erro


@onready var lever_animation = $BackgroundPanel/LeverAnimation
@onready var lever_sound = $LeverSound
@onready var equation_label = $BackgroundPanel/EquationScreen/EquationLabel
@onready var answer_input = $BackgroundPanel/AnswerSlot/LineEdit
@onready var light_off = $BackgroundPanel/LightsPanel/LightsOff
@onready var light_green = $BackgroundPanel/LightsPanel/LightGreen
@onready var light_red = $BackgroundPanel/LightsPanel/LightRed
@onready var alarm_sound = $AlarmSound


var respostas_corretas: Array[String] = []
var esta_verificando_resposta: bool = false

func _ready():
	gerar_nova_equacao()

func _on_lever_button_pressed():
	if esta_verificando_resposta:
		return

	esta_verificando_resposta = true
	
	lever_animation.play("Alavanca")
	lever_sound.play()

func _on_lever_animation_finished():

	var texto_usuario: String = answer_input.text.strip_edges()

	var respostas_usuario: Array[String] = []
	for parte in texto_usuario.split(","):
		if not parte.is_empty(): 
			respostas_usuario.append(parte.strip_edges())
	
	respostas_usuario.sort()

	var respostas_corretas_ordenadas = respostas_corretas.duplicate()
	respostas_corretas_ordenadas.sort()
	
	var esta_correto = (respostas_usuario == respostas_corretas_ordenadas)

	light_off.visible = false
	
	if esta_correto:
		light_green.visible = true
		light_red.visible = false

		puzzle_resolvido.emit()

	else:
		light_green.visible = false
		light_red.visible = true
		
		puzzle_erro.emit()
		alarm_sound.play()

		await alarm_sound.finished 
		
func gerar_nova_equacao():
	light_off.visible = true
	light_green.visible = false
	light_red.visible = false
	
	answer_input.text = ""
	
	if randf() < 0.75:
		var a = randi_range(1, 5)
		var b = randi_range(-10, 10)
		var x = randi_range(-5, 5)
		if x == 0: x = 1
		
		var c = (a * x) + b
		
		var texto_b = "+ %d" % b
		if b < 0:
			texto_b = "- %d" % abs(b)
			
		equation_label.text = "%dx %s = %d" % [a, texto_b, c]
		
		respostas_corretas = [str(x)]
		
	else:
		var a = randi_range(1, 3)
		var r1 = randi_range(-5, 5)
		var r2 = randi_range(-5, 5)
		
		var b = -a * (r1 + r2)
		var c = a * (r1 * r2)
		
		var texto_b = "+ %dx" % b
		if b < 0:
			texto_b = "- %dx" % abs(b)
		
		var texto_c = "+ %d" % c
		if c < 0:
			texto_c = "- %d" % abs(c)
			
		equation_label.text = "%dx² %s %s = 0" % [a, texto_b, texto_c]
		
		if r1 == r2:
			respostas_corretas = [str(r1)] 
		else:
			respostas_corretas = [str(r1), str(r2)]

	esta_verificando_resposta = false
