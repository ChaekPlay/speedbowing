extends VBoxContainer
@export var level_button: LevelSelectButton
@export var level_name_label: Label
@export var rank_label: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	if not Stats.level_exists(level_button.level_id):
		level_button.disabled = true
		level_name_label.text = "-"
		rank_label.text = "-"
	else:
		var level = Stats.levels[level_button.level_id-1]
		level_name_label.text = level.name
		if not Stats.player_level_stats.has(str(level.level_id)):
			print("??????????????????? ",level.level_id)
			rank_label.text = "-"
			return
		var time = Stats.player_level_stats[str(level.level_id)]
		print("time ", time)
		rank_label.text = "%2d.%03d (%s)" % [time,int(time * 1000) % 1000, Stats.get_rank(level.level_id, time)]
