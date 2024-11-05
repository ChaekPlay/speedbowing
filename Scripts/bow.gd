class_name Bow extends Node3D

@export var camera: PlayerCamera
@export var arrow: PackedScene
@export var projectile_place: Node
var max_power = 10
var current_power = 0
var power_scaling = 0.1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		if current_power == max_power:
			return
		current_power += power_scaling
		if current_power > max_power:
			current_power = max_power
	if Input.is_action_just_released("shoot"):
		print("Current bow strength: "+str(current_power))
		var arrow = arrow.instantiate()
		if arrow is Arrow:
			arrow.position = camera.global_position
			arrow.rotation = camera.global_rotation_degrees
			var impulse = -camera.global_transform.basis.z.normalized() * current_power
			arrow.apply_central_impulse(impulse)
			projectile_place.add_child(arrow)
		current_power = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
