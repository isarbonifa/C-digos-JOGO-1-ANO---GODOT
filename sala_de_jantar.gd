extends Node2D

@export var interactive_objects: Array[Area2D] = []
@onready var e_button: Sprite2D = $EDeInteragir

var primeira_vez = true
var current_index := 0
var e_tween: Tween = null

func _ready():
	
	if e_button:
		e_button.visible = false
	else:
		push_warning("⚠️ O nó 'EDeInteragir' não foi encontrado!")

	if interactive_objects.size() > 0:
		_update_focus()
	else:
		push_warning("⚠️ Nenhum objeto interativo adicionado em 'interactive_objects'!")

		
func _process(_delta):
	# Navegar entre objetos
	if Input.is_action_just_pressed("ui_right"):
		current_index = (current_index + 1) % interactive_objects.size()
		_update_focus()
	elif Input.is_action_just_pressed("ui_left"):
		current_index = (current_index - 1 + interactive_objects.size()) % interactive_objects.size()
		_update_focus()
	
		
	# Interagir (E)
	if Input.is_action_just_pressed("ui_accept"):
		var current = interactive_objects[current_index]
		if current.has_method("interact"):
			current.interact()
		else:
			print("Interagiu com:", current.name)

func _update_focus():
	var selected = interactive_objects[current_index]
	var shape_node = selected.get_node_or_null("CollisionShape2D")

	if not shape_node:
		push_warning("Objeto '%s' não tem CollisionShape2D!" % selected.name)
		return

	# Mostra o botão E
	if e_button:
		e_button.visible = true

		# 🔹 Define tamanho fixo na tela (em pixels)
		e_button.scale = Vector2(0.1, 0.1)
		e_button.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST  # mantém pixel art nítido

		# 🔹 Corrige o cálculo do offset
		var offset_y := -10.0
		var shape = shape_node.shape
		if shape is RectangleShape2D:
			offset_y = -(shape.size.y * selected.scale.y) / 2 - 16
		elif shape is CircleShape2D:
			offset_y = -shape.radius * selected.scale.y - 16
		elif shape is CapsuleShape2D:
			offset_y = -(shape.height * selected.scale.y) / 2 - 16

		e_button.position = selected.global_position + Vector2(0, offset_y)

		# 🔹 Remove animação anterior
		if e_tween and e_tween.is_running():
			e_tween.kill()

		# 🔹 Flutuação leve
		e_tween = get_tree().create_tween()
		var start_y = e_button.position.y
		e_tween.tween_property(e_button, "position:y", start_y - 5, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		e_tween.tween_property(e_button, "position:y", start_y, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		e_tween.set_loops()
