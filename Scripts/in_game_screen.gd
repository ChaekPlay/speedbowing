class_name InGameScreen extends Control

var level_time: float = 0
var counting: bool = true
@onready var level_time_label: Label = $LevelTimeLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if counting:
		level_time += delta
		level_time_label.text = "Время: "+str("%.3f" % level_time)

func _on_game_level_time_changed(time: float) -> void:
	pass # Replace with function body.
