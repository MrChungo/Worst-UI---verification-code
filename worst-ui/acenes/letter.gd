extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_mouse_shape_entered(shape_idx: int) -> void:
	Global.isMouseIn = true 
	print('in')


func _on_area_2d_mouse_shape_exited(shape_idx: int) -> void:
	Global.isMouseIn = false
	print("out") 
