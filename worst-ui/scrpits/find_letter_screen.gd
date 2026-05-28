extends Node2D


const KETTER_CsENE = preload("uid://df6cc4183ocaj") #"res://scenes/letter.tscn"

var lettersOnScreen: Array = []

func _ready() -> void:
	spawnpoints(2,2)

func spawnpoints(columns, rows) -> void:
	for r in range(columns):
		for c in range(rows):
			_spawn()

func _spawn() -> void:
	var x = randi_range(100, 800) 
	var y = randi_range(100, 600)
	var letter = KETTER_CsENE.instantiate()
	add_child(letter)
	lettersOnScreen.append(letter)
	print(letter.global_position)
	letter.global_position = (x,y)
