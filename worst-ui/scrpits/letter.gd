extends Node2D

signal letter_found(letter:Node2D)

func _on_area_2d_mouse_shape_entered(shape_idx: int) -> void:
	Globals.ItemMouseIsHoveringOver = self 
	print('in')



func _on_area_2d_mouse_shape_exited(shape_idx: int) -> void:
	Globals.ItemMouseIsHoveringOver = null
	print("out") 




func _on_textured_button_pressed() -> void:
	letter_found.emit(self)
