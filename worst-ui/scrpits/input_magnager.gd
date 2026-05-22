extends Node2D
class_name input_manager
signal leftMouseButtonClicked()




func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Sprite clicked!")
			leftMouseButtonClicked.emit(get_global_mouse_position())
# Called when the node enters the scene tree for the first time.
"""func _input(event):

   # Mouse in viewport coordinates
	if event is InputEventMouseButton:
		leftmousebuttonclicked.emit(get_global_mouse_position())
		print("Mouse Click/Unclick at: ", event.position)"""
