class_name Puzzle extends Node

@export var buttons: Array[PuzzleButton]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for button in buttons:
		button.connect("activated", checkButton)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func checkButton(button: PuzzleButton):
	var newMaterial = StandardMaterial3D.new() #Make a new Spatial Material
	newMaterial.albedo_color = Color(0, 1, 0, 1.0) #Set color of new material
	button.mesh.material_override = newMaterial #Assign new material to material overrride
	print("hit a button with id:", button.id)
	
