extends Node2D


func _on_area_2d_mouse_shape_entered() -> void:
	Globals.ItemMouseIsHoveringOver = self 
	print('in')



func _on_area_2d_mouse_shape_exited() -> void:
	Globals.ItemMouseIsHoveringOver = null
	print("out") 
