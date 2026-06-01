extends Control

signal button_pressed

const BUTTON_SCENE = preload("uid://cfmwgluma2am2") #"res://textured_button.tscn"

var buttons:Array = []

func _ready() -> void:
	createButtons(4,4)

func createButtons(columns, rows) -> void:
	$GridContainer.columns = columns
	for r in range(columns):
		for c in range(rows):
			createButton()
	

func createButton() -> void:
	var button = BUTTON_SCENE.instantiate()
	buttons.append(button)
	button.connect("pressed",on_button_pressed)
	$GridContainer.add_child(button)

func on_button_pressed():
	button_pressed.emit()


func clearAllButtons():
	pass
