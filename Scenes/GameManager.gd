extends Node3D
var level_time: float = 0
signal finished
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
			


func _on_finish_area_body_entered(body: Node3D) -> void:
	if body is Player:
		body.freeze = true
		body.rank_camera.make_current()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		finished.emit()
		
