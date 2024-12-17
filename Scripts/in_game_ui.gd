class_name InGameUI extends Control

@onready var in_game_screen: Control = $InGame
@onready var rank_screen: Control = $RankScreen
@onready var pause_screen: Control = $PauseScreen
@onready var final_time_label: Label = $RankScreen/ColorRect/VBoxContainer/FinalTimeLabel
@onready var rank_label = $RankScreen/ColorRect/VBoxContainer/RankLabel
@onready var level_time_label: Label = $InGame/LevelTimeLabel
@onready var power_bar: TextureProgressBar = $InGame/PowerBar
@onready var dash_bar: TextureProgressBar = $InGame/DashBar
@onready var next_button = $RankScreen/ColorRect/VBoxContainer/HBoxContainer/NextButton
@onready var select_sound = $SelectSound

signal quitPressed
signal nextLevelPressed
signal resumePressed
signal resetPressed

func _ready() -> void:
	level_time_label.text = "Время: "+str("%2d.%03d" % [0,0])

func set_new_power_value(value: float):
	power_bar.value = value

func add_dash_cooldown_percent(value: float):
	dash_bar.value += value
	

func set_new_dash_cooldown_percent(value:float):
	dash_bar.value = value

func set_current_level_time(time: float):
	var milliseconds = "%.3f" % time
	level_time_label.text = "Время: "+str("%2d.%03d" % [time,int(time * 1000) % 1000])

func finish_level(id: int, time: float):
	final_time_label.text = level_time_label.text
	rank_label.text = "Ранг: %s" % Stats.get_rank(id, time)
	next_button.disabled = Stats.level_count <= id
	switch_screen(in_game_screen, rank_screen)

func switch_screen(screen1: Control, screen2: Control):
	screen1.hide()
	screen2.show()


func _on_next_button_pressed() -> void:
	select_sound.play()
	nextLevelPressed.emit()


func _on_quit_button_pressed() -> void:
	select_sound.play()
	quitPressed.emit()


func _on_resume_button_pressed() -> void:
	select_sound.play()
	resumePressed.emit()

func _on_reset_button_pressed() -> void:
	select_sound.play()
	resetPressed.emit()
