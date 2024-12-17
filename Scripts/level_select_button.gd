class_name LevelSelectButton extends Button

signal level_selected(level_id: int)

@export var select_sound: AudioStreamPlayer
@export var level_id: int

func _on_pressed() -> void:
	select_sound.play()
	level_selected.emit(level_id)
