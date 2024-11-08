class_name Arrow extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node) -> void:
	print("collision")
	if body is PuzzleButton:
		print("arrow hit a button")
		body.activated.emit(body)
