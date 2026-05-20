@tool
extends CharacterBody2D

@export var speed: float

@onready var target_position:Vector2 = get_global_mouse_position()

var movement_tween = Tween.new()

func _input(event: InputEvent) -> void:
	if event

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	pass
