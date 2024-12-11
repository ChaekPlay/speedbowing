class_name Bow extends Node3D
@export var player: Player
@export var arrow: PackedScene
@export var projectile_place: Node
var max_power = 50
var current_power = 0
var power_scaling = 0.5
var min_power = 5

signal power_changed(value: float)

func increase_power():
	if current_power == max_power:
		return
	current_power += power_scaling
	if current_power > max_power:
		current_power = max_power
	power_changed.emit(current_power / max_power * 100)

func shoot():
	var arrow: Arrow = arrow.instantiate()
	
	var camera_dir = -player.camera.global_transform.basis.z.normalized()
	arrow.transform = player.camera.global_transform
	arrow.translate_object_local(Vector3(0,0,-1))
	arrow.rotate_object_local(Vector3(1,0,0), deg_to_rad(-90))
	
	print(arrow.rotation)
	
	var impulse = camera_dir * current_power
	arrow.apply_impulse(impulse)
	projectile_place.add_child(arrow)
	

func _physics_process(delta: float) -> void:
	if player.freeze:
			return
	if Input.is_action_pressed("shoot"):
		increase_power()
	if Input.is_action_just_released("shoot"):
		if current_power > min_power:
			print("Current bow strength: "+str(current_power))
			if player.can_shoot:
				shoot()
		current_power = 0
		power_changed.emit(current_power / max_power * 100)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
