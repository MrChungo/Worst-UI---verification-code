extends Control

const BUTTON_SCENE = preload("uid://cfmwgluma2am2") #"res://textured_button.tscn"

var buttons:Array = []

func _ready() -> void:
	createButtons(6,4)

func createButtons(columns, rows) -> void:
	$GridContainer.columns = columns
	for r in range(columns):
		for c in range(rows):
			createButton()
	

func createButton():
	var button = BUTTON_SCENE.instantiate()
	buttons.append(button)
	$GridContainer.add_child(button)


func clearAllButtons():
	pass
