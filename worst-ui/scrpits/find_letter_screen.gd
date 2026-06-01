extends Node2D


const KETTER_CsENE = preload("uid://df6cc4183ocaj") #"res://scenes/letter.tscn"

var lettersOnScreen: Array = []
var screen_size = DisplayServer.window_get_size()
var screen_width: int = int(screen_size.x)
var screen_height: int = int(screen_size.y)

func _ready() -> void:
	spawnpoints(2,1)

## Gets locations where letters can spawn
func spawnpoints(columns:int, rows:int) -> void:
	for r in range(columns):
		for c in range(rows):
			_spawn()



##spawns the things
func _spawn() -> void:

	var letter = KETTER_CsENE.instantiate()
	$"letter container".add_child(letter)
	lettersOnScreen.append(letter)
	letter.global_position = get_random_pos()
	for child in $"letter container".get_children():
		if do_overlap(letter, child):
			print("WRONG")
			letter.global_position = get_random_pos()
			


func get_random_pos() ->Vector2:
	@warning_ignore("integer_division")
	var x = randi_range(-screen_width/2, screen_width/2) 
	@warning_ignore("integer_division")
	var y = randi_range(-screen_height/2, screen_height/2)
	return Vector2(x,y)

func do_overlap(letter1, letter2) -> bool:
	return letter1.get_node("Sprite2D").get_rect().intersects(letter2.get_node("Sprite2D").get_rect())
