class_name RangeValueText extends Label

var value: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# maybe get from settings file ???
	pass # Replace with function body.




func _on_sound_range_value_changed(value: float) -> void:
	text = "%2d" % value
	pass # Replace with function body.
