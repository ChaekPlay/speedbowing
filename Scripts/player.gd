class_name Player extends CharacterBody3D

@onready var player_camera: PlayerCamera = $PlayerCamera

const SPEED = 10.0
const JUMP_VELOCITY = 6

var cam_vector = Vector3()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cam_vector.y -= (event.relative.x * player_camera.yaw)
		cam_vector.x -= (event.relative.y * player_camera.pitch)
		cam_vector.x = clamp(cam_vector.x, -80, 90)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	player_camera.rotation_degrees.x = cam_vector.x
	rotation_degrees.y = cam_vector.y
