class_name MainMenuButton extends Button
@export var select_sound: AudioStreamPlayer
@export var current_menu: Control
@export var next_menu: Control



func _on_pressed() -> void:
	select_sound.play()
	next_menu.show()
	current_menu.hide()
