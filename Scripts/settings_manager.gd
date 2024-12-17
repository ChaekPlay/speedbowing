extends Node

var sound_value: int = 10
var music_value: int = 10
var save_file = "user://settings.data"
func _ready() -> void:
	load_data()

func save_data():
	var file = FileAccess.open(save_file, FileAccess.WRITE)
	file.store_8(sound_value)
	file.store_8(music_value)
	file.close()
	
func load_data():
	if not FileAccess.file_exists(save_file):
		return
	var file = FileAccess.open(save_file, FileAccess.READ)
	sound_value = file.get_8()
	music_value = file.get_8()
	file.close()
