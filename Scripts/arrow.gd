class_name Arrow extends RigidBody3D

@onready var dissapear_timer: Timer = $DissapearTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node) -> void:
	print("collision")
	freeze = true
	if body is PuzzleButton:
		print("arrow hit a button")
		body.activated.emit(body)
	dissapear_timer.start()


func _on_dissapear_timer_timeout() -> void:
	queue_free()
