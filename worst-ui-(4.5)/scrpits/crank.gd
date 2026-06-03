@tool
extends CharacterBody2D

var isGrabbed:bool = true

var mouseEntered:bool = false

var shortestDistanceToMouse:Vector2

@export var speed: float

@onready var target_position:Vector2 = get_global_mouse_position()

var movement_tween = create_tween()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			#print(get_shortest_vector_to_mouse())
			print(get_direction_vector(get_shortest_vector_to_mouse()))



@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	if isGrabbed:
		velocity = get_direction_vector(get_shortest_vector_to_mouse()) * speed
		move_and_slide()
	
	

func get_shortest_vector_to_mouse() -> Vector2:
	return  get_global_mouse_position() - position

func get_direction_vector(vector:Vector2) -> Vector2:
	return global_position.direction_to(vector)




func _on_mouse_entered() -> void:
	mouseEntered = true


func _on_mouse_exited() -> void:
	mouseEntered = false
