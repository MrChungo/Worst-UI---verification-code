extends Node2D

signal update_password_display(text:String)

const LETTER_SCENE = preload("uid://df6cc4183ocaj") #"res://scenes/letter.tscn"
const STUFFS_SCENE = preload("uid://mjch22nnwkx7") #"res://scenes/Props/Stuffs.tscn"

@export var target_password: String = "12345678"

var current_password = ""

var letters_on_screen: Array = []
var stuff_on_screen:Array = []


var screen_size = DisplayServer.window_get_size()
var screen_width: int = int(screen_size.x)
var screen_height: int = int(screen_size.y)



func _ready() -> void:
	$"..".connect("enable_letters",enable_letters)
	$"..".connect("disable_letters",disable_letters)
	spawn_letters(len(target_password))
	spawn_stuffs(len(target_password)*2)
	


func spawn_letters(letter_quantity: int) -> void:
	for letter in range(letter_quantity):
		var letter_symbol = target_password[letter]
		_spawn_letter(letter_symbol)

func _spawn_letter(letter_symbol:String) -> void:
	var letter = LETTER_SCENE.instantiate()
	$"letter container".add_child(letter)
	
	await get_tree().process_frame
	letter.letter_found.connect(letter_found)
	letter.get_node("TexturedButton").get_node("RichTextLabel").text = letter_symbol
	
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
				var existing_rect = Rect2(existing_letter.position - (letter_size / 2.0), letter_size)
				
				if new_rect.intersects(existing_rect):
					collision_found = true
					break # Stop checking other letters, this spot is bad
		
		# If it didn't hit any existing letters, it's a valid spot!
		if not collision_found:
			valid_position = true

	# Set the position and save it to our tracking array
	letter.position = spawn_pos
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


func letter_found(letter):
	current_password += letter.get_node("TexturedButton").get_node("RichTextLabel").text
	letters_on_screen.erase(letter)
	update_password_display.emit(current_password)
	letter.queue_free()
	if current_password == target_password:
		get_tree().quit()
	elif letters_on_screen.size() == 0:
		reset_board()

func enable_letters():
	for letter in letters_on_screen:
		letter.get_node("TexturedButton").disabled = false

func disable_letters():
	for letter in letters_on_screen:
		letter.get_node("TexturedButton").disabled = true


func spawn_stuffs(stuff_quantity: int) -> void:
	for stuff in range(stuff_quantity):
		_spawn_stuff()

func _spawn_stuff() -> void:
	var stuff = STUFFS_SCENE.instantiate()
	$StuffContainer.add_child(stuff)
	await get_tree().process_frame
	
	position_stuff(stuff)

func position_stuff(stuff):
	var stuff_size = Vector2(stuff.chosen_texture.texture.get_width(),stuff.chosen_texture.texture.get_height())
	
	var valid_position = false
	var spawn_pos = Vector2.ZERO
	
	var max_attempts = 100
	var attempts = 0
	
	while not valid_position and attempts < max_attempts:
		spawn_pos = get_random_pos(stuff_size)
		attempts += 1
		
		# Create a bounding box for the new letter at this random position
		# (Assuming your letter's position is centered. If it's top-left, remove the "- LETTER_SIZE / 2")
		var new_rect = Rect2(spawn_pos - (stuff_size / 2.0), stuff_size)
		
		var collision_found = false
		
		# Check this new box against every letter we already spawned
		for existing_stuff in stuff_on_screen:
			if is_instance_valid(existing_stuff):
				var existing_rect = Rect2(existing_stuff.position - (stuff_size / 2.0), stuff_size)
				
				if new_rect.intersects(existing_rect):
					collision_found = true
					break # Stop checking other letters, this spot is bad
		
		# If it didn't hit any existing letters, it's a valid spot!
		if not collision_found:
			valid_position = true

	# Set the position and save it to our tracking array
	stuff.position = spawn_pos
	stuff_on_screen.append(stuff)

	if attempts >= max_attempts:
		print("Warning: Could not find a collision-free spot for ", stuff.name)


func reset_board():
	current_password = ""
	for letter in letters_on_screen:
		letter.queue_free()
	letters_on_screen.clear()
	update_password_display.emit(current_password)
	spawn_letters(len(target_password))
