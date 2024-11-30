extends Node

func changeScene(path: String):
	var scene = load(path)
	get_tree().change_scene_to_packed(scene)
