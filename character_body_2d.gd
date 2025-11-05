extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const GRAVITY = 1000.0

@onready var anim = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if not is_on_floor():
		# no ar → mostra o lado que ele tava virado antes
		if anim.animation == "mov_right" or anim.animation == "parado_direita":
			anim.play("parado_direita")
		elif anim.animation == "mov_left" or anim.animation == "parado_esquerda":
			anim.play("parado_esquerda")
	else:
	# define qual animação tocar
		if direction > 0:
			anim.play("mov_right")
		elif direction < 0:
			anim.play("mov_left")
		else:
		# se estiver parado, escolhe o lado baseado na última direção
			if anim.animation == "mov_right" or anim.animation == "parado_direita":
				anim.play("parado_direita")
			elif anim.animation == "mov_left" or anim.animation == "parado_esquerda":
				anim.play("parado_esquerda")
			
	move_and_slide()
