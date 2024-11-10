extends AnimatableBody3D


func _on_puzzle_solved() -> void:
	queue_free()
