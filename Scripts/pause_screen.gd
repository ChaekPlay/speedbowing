class_name PauseScreen extends Control

signal pause_toggled
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_resume_button_pressed() -> void:
	pause_toggled.emit()
	

func _on_exit_button_pressed() -> void:
	pause_toggled.emit()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var scene = load("res://Scenes/main_menu.tscn")
	get_tree().change_scene_to_packed(scene)
