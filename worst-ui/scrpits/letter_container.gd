extends Node2D

@export var inputManager: input_manager

var lettersOnScreen: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inputManager.leftMouseButtonClicked.connect(click_letter())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func click_letter() -> void:
	pass
