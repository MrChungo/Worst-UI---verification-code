extends Node2D

var chosen_texture:Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_random_texture()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_random_texture():
	var textures = get_children()
	
	# Turn them all off
	for child in textures:
		child.visible = false
	
	# Pick a random child directly from the array and make it visible
	if not textures.is_empty():
		var chosen_child = textures.pick_random()
		chosen_texture = chosen_child
		chosen_child.visible = true
	
