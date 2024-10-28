class_name PlayerCamera extends Camera3D

@export var pitch = 0.001
@export var yaw = 0.001
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
