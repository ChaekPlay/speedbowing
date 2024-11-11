extends Control

@onready var in_game_ui: InGameScreen = $InGame
@onready var rank_screen: RankScreen = $RankScreen
@onready var pause_screen: PauseScreen = $PauseScreen
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func toggle_pause():
	in_game_ui.counting = !in_game_ui.counting
	get_tree().paused = !get_tree().paused
	pause_screen.visible = !pause_screen.visible
	if pause_screen.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		toggle_pause()
	


func _on_game_finished() -> void:
	in_game_ui.counting = false
	in_game_ui.hide()
	rank_screen.final_time_label.text = in_game_ui.level_time_label.text
	rank_screen.show()

func _on_pause_screen_pause_toggled() -> void:
	toggle_pause()
