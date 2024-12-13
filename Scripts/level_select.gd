extends Control

func _on_button_level_selected(level_id: int) -> void:
	print("level id: ",level_id)
	var scene = load("res://Scenes/level"+str(level_id)+".tscn")
	get_tree().change_scene_to_packed(scene)
