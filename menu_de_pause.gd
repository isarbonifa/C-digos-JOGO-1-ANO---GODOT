extends CanvasLayer

@onready var texto = $"PainelPrincipal/Opções/Label"
@onready var voltar_btn = $"PainelPrincipal/Opções/voltar"
@onready var continuar_btn = $PainelPrincipal/Continuar

func _ready():
	visible = false
	
	
func _process(_delta):
	pass
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"): # ESC
		visible = true
		voltar_btn.visible = false
		texto.visible = false
		continuar_btn.grab_focus()
		get_tree().paused = true

func _on_continuar_pressed():
	get_tree().paused = false
	visible = false
	
func _on_opções_pressed() -> void:
	voltar_btn.visible = true
	texto.visible = true
	
func _on_sair_do_jogo_pressed():
	get_tree().quit()

func _on_voltar_pressed() -> void:
	voltar_btn.visible = false
	texto.visible = false
	continuar_btn.grab_focus()
