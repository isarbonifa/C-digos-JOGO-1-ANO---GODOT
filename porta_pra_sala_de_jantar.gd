extends Area2D

@onready var e_button: Sprite2D = $EDeInteragir
var e_tween: Tween = null
var player_in_area := false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	e_button.visible = false

func _process(_delta):
	if player_in_area and Input.is_action_just_pressed("ui_accept"):
		interact()

func interact():
	print("Kiwi entrou na sala de estar")
	Transição.change_scene_with_fade("res://sala_de_jantar.tscn")

	
func _on_body_entered(body):
	if body is CharacterBody2D:
		player_in_area = true
		_update_focus()

func _on_body_exited(body):
	if body is CharacterBody2D:
		player_in_area = false
		e_button.visible = false

func _update_focus():
	var shape_node = $CollisionShape2D
	var offset_y := -16.0
	if shape_node and shape_node.shape is RectangleShape2D:
		offset_y = -(shape_node.shape.size.y * scale.y) / 2 - 16

	e_button.visible = true
	e_button.position = Vector2(0, offset_y)  # posição local
	# animação de flutuação
	if e_tween and e_tween.is_running():
		e_tween.kill()
	e_tween = get_tree().create_tween()
	var start_y = e_button.position.y
	e_tween.tween_property(e_button, "position:y", start_y - 5, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	e_tween.tween_property(e_button, "position:y", start_y, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	e_tween.set_loops()
