extends Control
@onready var label: Label = $Label
@onready var label2: Label = $Label2

func _ready():
	var new_font_size = 32 # Set your desired font size
	label.add_theme_font_size_override("font_size", new_font_size)
	label2.add_theme_font_size_override("font_size", new_font_size)

func set_score(value):
	label2.text += str(value)

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
