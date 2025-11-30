extends Control

@onready var menu_music: AudioStreamPlayer = $"Menu-music"


func _ready():
	menu_music.play()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
