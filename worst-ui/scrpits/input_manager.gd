extends Node2D
class_name input_manager

signal leftMouseButtonClicked




func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print(event.position)
			leftMouseButtonClicked.emit()
# Called when the node enters the scene tree for the first time.
