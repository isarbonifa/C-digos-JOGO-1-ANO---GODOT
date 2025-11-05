extends LineEdit

var primeira_vez = true

func _ready():
	# Duração do fade em segundos
	var fade_duration = 10.0
	var timer = 0.0
	
	while timer < fade_duration:
		# Calcula quanto já passou do tempo total
		timer += get_process_delta_time()
		# Ajusta a opacidade de 1.0 para 0.0 gradualmente
		modulate.a = lerp(1.0, 0.0, timer / fade_duration)
		await get_tree().process_frame
	hide()
	
