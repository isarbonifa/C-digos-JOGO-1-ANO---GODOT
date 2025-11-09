extends VideoStreamPlayer

@onready var chuva = $AudioStreamPlayer2D

func _ready():
	chuva.play()

func _on_finished() -> void:
	TransiçãoCorredor.change_scene_with_fade("res://corredor_terreo.tscn")


func _on_pular_pressed() -> void:
	TransiçãoCorredor.change_scene_with_fade("res://corredor_terreo.tscn")
