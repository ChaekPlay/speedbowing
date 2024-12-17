extends Control
@export var select_sound: AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_button_pressed() -> void:
	select_sound.play()
	Stats.save_data()
	SettingsManager.save_data()
	get_tree().call_deferred("quit")
