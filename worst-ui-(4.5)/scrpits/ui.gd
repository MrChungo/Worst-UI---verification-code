extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../ScreenManager".connect("update_password_display",update_PasswordDisplay)
	position()



func position():
	var scale_factor = 4.0
	var new_button_scale = Vector2(scale_factor,scale_factor)
	
	%"Next Screen".position = Vector2(Globals.screen_size.x * 0.40, Globals.screen_size.y * 0.40)
	%"Next Screen".scale = new_button_scale
	%"Next Screen".button_scale = scale_factor
	
	%"Previous Screen".position = Vector2(Globals.screen_size.x * -0.40, Globals.screen_size.y * 0.40)
	%"Previous Screen".scale = new_button_scale
	%"Previous Screen".button_scale = scale_factor
	
	$MarginContainer.pivot_offset = -$MarginContainer.size / 2
	$MarginContainer.position = Vector2($MarginContainer.position.x, -Globals.screen_size.y * 0.45)
	


func update_PasswordDisplay(text):
	$MarginContainer/HBoxContainer/PasswordDisplay.text = text
