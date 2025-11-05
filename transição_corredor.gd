extends Control

@onready var anim = $AnimationPlayer
@onready var tela = $ColorRect
@onready var transição_corredor = $AudioStreamPlayer2D

func change_scene_with_fade(scene_path: String):
	# toca o som de porta
	transição_corredor.play()
	# toca o fade_out
	anim.play("fade_out")
	await anim.animation_finished
	get_tree().change_scene_to_file(scene_path)
	# toca o som de porta de novo na entrada
	anim.play("fade_in")
