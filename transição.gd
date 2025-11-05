extends Control

@onready var anim = $AnimationPlayer
@onready var tela = $ColorRect
@onready var som_porta = $AudioStreamPlayer2D

func change_scene_with_fade(scene_path: String):
	# toca o som de porta
	som_porta.play()
	# toca o fade_out
	anim.play("fade_out")
	await anim.animation_finished
	get_tree().change_scene_to_file(scene_path)
	# toca o som de porta de novo na entrada
	anim.play("fade_in")
