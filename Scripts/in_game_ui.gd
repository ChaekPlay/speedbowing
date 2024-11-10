extends Control

@onready var in_game_ui: InGameScreen = $InGame
@onready var rank_screen: RankScreen = $RankScreen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_game_finished() -> void:
	in_game_ui.counting = false
	in_game_ui.hide()
	rank_screen.final_time_label.text = in_game_ui.level_time_label.text
	rank_screen.show()
