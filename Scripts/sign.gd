
extends Node3D
@onready var sign_label = $SignText
@export_multiline var sign_text: String
# Called when the node enters the scene tree for the first time.
func _ready():
	sign_label.text = sign_text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
