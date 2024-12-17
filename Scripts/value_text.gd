class_name RangeValueText extends Label

var value: int = 10
@export var bus_name: String
@export var slider: HSlider
var sound_scaling: float = 0.05
var bus_index: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	if bus_name == "Music":
		value = SettingsManager.music_value
	else:
		value = SettingsManager.sound_value
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value*sound_scaling))
	slider.value = value

func _on_sound_range_value_changed(value: float) -> void:
	print("volume changed")
	if bus_name == "Music":
		SettingsManager.music_value = value
	else:
		SettingsManager.sound_value = value
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value*sound_scaling))
	text = "%2d" % value
