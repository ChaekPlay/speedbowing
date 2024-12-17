extends Node

var levels: Array[Level] = []
var level_count = 1
var player_level_stats = {}
var save_file = "user://savegame.save"

func level_exists(id:int):
	return level_count >= id

func load_levels():
	for i in range(level_count):
		levels.append(load("res://Resources/level"+str(i+1)+".tres"))
	print(levels)

func get_rank(id: int, time: float):
	print("time ", time)
	print(levels[id-1].rank_distribution)
	for rank in levels[id-1].rank_distribution:
		if time < levels[id-1].rank_distribution[rank]:
			return rank
	return 'E'

func insert_stat(id: int, time: float):
	if not player_level_stats.has(str(id)):
		player_level_stats[str(id)] = time
		return
	if player_level_stats[str(id)] < time:
		return
	player_level_stats[str(id)] = time

# Called when the node enters the scene tree for the first time.
func _ready():
	load_levels()
	load_data()
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_data()
		get_tree().quit()

func save_data():
	var file = FileAccess.open(save_file, FileAccess.WRITE)
	var stats = JSON.stringify(player_level_stats)
	file.store_line(stats)
	file.close()
	
func load_data():
	if not FileAccess.file_exists(save_file):
		return
	var file = FileAccess.open(save_file, FileAccess.READ)
	var json_str = file.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_str)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message())
		return
	player_level_stats = json.data
	file.close()
	
