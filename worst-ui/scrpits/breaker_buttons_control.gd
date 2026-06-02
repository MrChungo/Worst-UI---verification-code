extends Control



signal button_pressed

const BUTTON_SCENE = preload("uid://cfmwgluma2am2") #"res://textured_button.tscn"

var buttons:Array = []

func _ready() -> void:
	createButtons(4,4)

func createButtons(columns, rows) -> void:
	$GridContainer.columns = columns
	for r in range(rows):
		buttons.append(Array())
		for c in range(columns):
			createButton()

func createButton() -> void:
	var button = BUTTON_SCENE.instantiate()
	buttons[-1].append(button)
	button.connect("pressed",on_button_pressed)
	$GridContainer.add_child(button)

func has_deactivated_row() -> bool:
	for row in buttons:
		var row_is_clear = true
		
		for breaker in row:
			if breaker.button_pressed:
				row_is_clear = false
				break # Stop checking THIS row, it has an active button
				
		if row_is_clear:
			return true # Found ONE completely deactivated row!
			
	return false # Checked all rows, none were completely clear


func has_deactivated_column() -> bool:
	if buttons.is_empty() or buttons[0].is_empty():
		return false
		
	var num_rows = buttons.size()
	var num_cols = buttons[0].size()
	
	for col in range(num_cols):
		var col_is_clear = true
		
		for row in range(num_rows):
			if buttons[row][col].button_pressed:
				col_is_clear = false
				break # Stop checking THIS column
				
		if col_is_clear:
			return true # Found ONE completely deactivated column!
			
	return false # Checked all columns, none were completely clear



func on_button_pressed():
	button_pressed.emit()


func clearAllButtons():
	pass
