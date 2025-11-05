extends Node2D

func _input(event):
	if event.is_action_pressed("ui_cancel"): # ESC
		if get_tree().paused:
			resume_game()
			print("Despausando...")
		else:
			pause_game()
			print("Pausando...")

func pause_game():
	print("Mostrando menu...")
	$MenuDePause.visible = true
	$"MenuDePause/MenuDeOpções".visible = false
	get_tree().paused = true

func resume_game():
	$MenuDePause.visible = false
	$MenuDePause/PainelPrincipal.visible = false
	get_tree().paused = false

func _on_continuar_pressed():
	resume_game()

func _on_sair_do_jogo_pressed():
	get_tree().quit()

func _on_opções_pressed():
	$"MenuDePause/MenuDeOpções".visible = true
	$MenuDePause/PainelPrincipal.visible = false

func _on_voltar_pressed():
	$"MenuDePause/MenuDeOpções".visible = false
	$MenuDePause/PainelPrincipal.visible = true
