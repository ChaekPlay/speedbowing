class_name Player extends CharacterBody3D

@onready var camera: PlayerCamera = $PlayerCamera
@onready var rank_camera: Camera3D = $RankScreenCamera
@onready var dash_cooldown = $DashCooldown
@onready var dash_timer = $DashTimer
@onready var dash_update_timer: Timer = $DashUpdateTimer
@export var player_start_marker: Marker3D
signal dash_cooldown_changed(percent_value: float)
signal dash_cooldown_percent_added(percent_value: float)

const SPEED = 10.0
const JUMP_VELOCITY = 6
const DASH_SPEED = 50
const DASH_DURATION = 0.3
const DASH_COOLDOWN = 2
var can_shoot = false
var can_dash = true
var is_dashing = false
var dash_vector = Vector3()
var cam_vector = Vector3()
var saved_y_velocity = 0
var freeze = false

func _ready() -> void:
	dash_timer.wait_time = DASH_DURATION
	dash_cooldown.wait_time = DASH_COOLDOWN
	global_position = player_start_marker.global_position

func _input(event: InputEvent) -> void:
	if freeze:
		return
	if event is InputEventMouseMotion:
		cam_vector.y -= (event.relative.x * camera.yaw)
		cam_vector.x -= (event.relative.y * camera.pitch)
		cam_vector.x = clamp(cam_vector.x, -80, 90)

func _physics_process(delta: float) -> void:
	if freeze:
		return
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
	
	if Input.is_action_just_pressed("dash") and can_dash:
		#print("dash")
		can_dash = false
		is_dashing = true
		dash_vector = Vector3()
		if input_dir.y != 0:
			dash_vector += input_dir.y * camera.global_transform.basis.z.normalized()
		if input_dir.x != 0:
			dash_vector += input_dir.x * camera.global_transform.basis.x.normalized()
		if input_dir.y == 0 and input_dir.x == 0:
			dash_vector += -camera.global_transform.basis.z.normalized()
		saved_y_velocity = velocity.y
		dash_cooldown_changed.emit(0)
		dash_timer.start()
	
	if is_dashing:
		velocity = dash_vector * DASH_SPEED
	elif direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
	camera.rotation_degrees.x = cam_vector.x
	rotation_degrees.y = cam_vector.y


func _on_dash_timer_timeout():
	is_dashing = false
	velocity.y = saved_y_velocity
	dash_cooldown.start()
	dash_update_timer.start()


func _on_dash_cooldown_timeout():
	dash_update_timer.stop()
	dash_cooldown_changed.emit(100)
	can_dash = true


func _on_dash_update_timer_timeout() -> void:
	dash_cooldown_percent_added.emit(dash_update_timer.wait_time / DASH_COOLDOWN * 100)
