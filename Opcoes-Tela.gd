extends ColorRect

@onready var voltar_btn = $voltar_btn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	voltar_btn.grab_focus()


func _on_voltar_btn_pressed() -> void:
	TransiçãoCorredor.change_scene_with_fade("res://scene/control.tscn")
