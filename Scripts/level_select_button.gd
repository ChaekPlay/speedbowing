extends Button

signal level_selected(level_id: int)

@export var level_id: int




func _on_pressed() -> void:
	level_selected.emit(level_id)
