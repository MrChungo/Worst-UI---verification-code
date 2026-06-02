extends Node2D

@export var screens:Array[Node2D]

var current_screen_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screens[1].scale = Vector2(3,3)
	screens[1].global_position.x = Globals.screen_size.x



func _on_next_screen_pressed() -> void:
	current_screen_index += 1
	var tween = create_tween()
	$"../UI/Next Screen".visible = false
	$"../UI/Previous Screen".visible = true
	tween.tween_property(self,"position",Vector2(-screens[current_screen_index].global_position.x,0),1.0)


func _on_previous_screen_pressed() -> void:
	current_screen_index -= 1
	var tween = create_tween()
	$"../UI/Next Screen".visible = true
	$"../UI/Previous Screen".visible = false
	tween.tween_property(self,"position",Vector2(screens[current_screen_index].position.x,0),1.0)
