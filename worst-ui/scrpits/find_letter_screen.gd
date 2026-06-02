extends Node2D

const LETTER_SCENE = preload("uid://df6cc4183ocaj") #"res://scenes/letter.tscn"

@export var target_password: String = "12345678"

var current_password = ""

var letters_on_screen: Array = []
var screen_size = DisplayServer.window_get_size()
var screen_width: int = int(screen_size.x)
var screen_height: int = int(screen_size.y)



func _ready() -> void:
	spawn_letters(8)

func spawn_letters(letter_quantity: int) -> void:
	for letter in range(letter_quantity):
		_spawn_letter()

func _spawn_letter() -> void:
	var letter = LETTER_SCENE.instantiate()
	$"letter container".add_child(letter)
	position_letter(letter)
	

func position_letter(letter):
	var letter_size = Vector2(letter.get_node("Sprite2D").texture.get_width(),letter.get_node("Sprite2D").texture.get_height())
	
	var valid_position = false
	var spawn_pos = Vector2.ZERO
	
	var max_attempts = 100
	var attempts = 0
	
	while not valid_position and attempts < max_attempts:
		spawn_pos = get_random_pos(letter_size)
		attempts += 1
		
		# Create a bounding box for the new letter at this random position
		# (Assuming your letter's position is centered. If it's top-left, remove the "- LETTER_SIZE / 2")
		var new_rect = Rect2(spawn_pos - (letter_size / 2.0), letter_size)
		
		var collision_found = false
		
		# Check this new box against every letter we already spawned
		for existing_letter in letters_on_screen:
			if is_instance_valid(existing_letter):
				var existing_rect = Rect2(existing_letter.global_position - (letter_size / 2.0), letter_size)
				
				if new_rect.intersects(existing_rect):
					collision_found = true
					break # Stop checking other letters, this spot is bad
		
		# If it didn't hit any existing letters, it's a valid spot!
		if not collision_found:
			valid_position = true

	# Set the position and save it to our tracking array
	letter.global_position = spawn_pos
	letters_on_screen.append(letter)

	if attempts >= max_attempts:
		print("Warning: Could not find a collision-free spot for ", letter.name)


func get_random_pos(letter_size) -> Vector2:
	# Accounting for the camera centered at 0,0
	# We also pad by half the letter size so they don't clip off the edges of the screen
	var x_margin = screen_width / 2.0 - (letter_size.x / 2.0)
	var y_margin = screen_height / 2.0 - (letter_size.y / 2.0)
	
	var x = randf_range(-x_margin, x_margin) 
	var y = randf_range(-y_margin, y_margin)
	return Vector2(x, y)
