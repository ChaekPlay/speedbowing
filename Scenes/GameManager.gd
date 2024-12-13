class_name LevelManager extends Node3D

enum GameState{
	NOT_STARTED,
	INGAME,
	FINISHED
}

@export var level_id = -1
@export var ui: InGameUI
var state = GameState.NOT_STARTED
var level_time: float = 0
var paused: bool = false

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _process(delta: float) -> void:
	if state == GameState.INGAME:
		level_time += delta
		ui.set_current_level_time(level_time)
	if Input.is_action_just_pressed("pause") and state != GameState.FINISHED:
		toggle_pause()
	
func start_level():
	state = GameState.INGAME
	
func finish_level():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	state = GameState.FINISHED
	Stats.insert_stat(level_id, level_time)
	ui.switch_screen(ui.in_game_screen, ui.rank_screen)
	ui.finish_level(level_id, level_time)

func reset_level():
	get_tree().paused = false
	get_tree().call_deferred("reload_current_scene")

func toggle_pause():
	paused = !paused
	if paused:
		ui.switch_screen(ui.in_game_screen, ui.pause_screen)
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		ui.switch_screen(ui.pause_screen, ui.in_game_screen)
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = !get_tree().paused

func next_level():
	get_tree().paused = false
	SceneManager.changeScene("res://Scenes/level"+str(level_id+1)+".tscn")
	
func main_menu():
	get_tree().paused = false
	SceneManager.changeScene("res://Scenes/main_menu.tscn")

func _on_finish_area_body_entered(body: Node3D) -> void:
	if body is Player:
		body.freeze = true
		body.rank_camera.make_current()
		finish_level()

func _on_start_area_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if body is Player:
		body.can_shoot = true
		start_level()


func _on_death_area_body_entered(body: Node3D) -> void:
	if body is Player:
		reset_level()
