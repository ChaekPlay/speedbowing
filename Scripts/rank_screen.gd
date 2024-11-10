class_name RankScreen extends Control
@export var level_id: int
@onready var final_time_label: Label = $ColorRect/VBoxContainer/FinalTimeLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_next_button_pressed() -> void:
	var scene = load("res://Materials/level"+str(level_id)+".tres")
	get_tree().change_scene_to_packed(scene)


func _on_quit_button_pressed() -> void:
	var scene = load("res://Scenes/main_menu.tscn")
	get_tree().change_scene_to_packed(scene)
