class_name MainMenuButton extends Button

@export var current_menu: Control
@export var next_menu: Control



func _on_pressed() -> void:
	next_menu.show()
	current_menu.hide()
