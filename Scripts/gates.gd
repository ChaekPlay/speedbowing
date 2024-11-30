extends AnimatableBody3D


func _on_puzzle_solved() -> void:
	$AnimationPlayer.play("gate_open")
