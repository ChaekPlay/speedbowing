extends Control

func _on_button_level_selected(level_id: int) -> void:
	var scene = load("res://Scenes/level"+str(level_id)+".tscn")
	get_tree().change_scene_to_packed(scene)
