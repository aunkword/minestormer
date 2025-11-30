extends Control
@onready var score_text: Label = $ScoreText

func set_score(value):
	score_text.text += str(value)


func _on_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
