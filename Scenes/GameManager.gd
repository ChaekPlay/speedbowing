extends Node3D
var level_time: float = 0
signal finished
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
			


func _on_finish_area_body_entered(body: Node3D) -> void:
	if body is Player:
		body.freeze = true
		body.rank_camera.make_current()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		finished.emit()
		
