extends Node2D


signal update_password_display(text:String)
signal disable_letters
signal enable_letters

@export var screens:Array[Node2D]

var current_screen_index = 0
var last_power_check:bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screens[1].scale = Vector2(3,3)
	screens[1].global_position.x = Globals.screen_size.x
	$BreakerScreen.connect("power_offline",power_offline)
	$BreakerScreen.connect("power_online",power_online)
	$"find letter screen".connect("update_password_display",signal_update_password_display)



func _on_next_screen_pressed() -> void:
	current_screen_index += 1
	var tween = create_tween()
	%"Next Screen".visible = false
	%"Previous Screen".visible = true
	tween.tween_property(self,"position",Vector2(-screens[current_screen_index].global_position.x,0),1.0)


func _on_previous_screen_pressed() -> void:
	current_screen_index -= 1
	var tween = create_tween()
	%"Next Screen".visible = true
	%"Previous Screen".visible = false
	tween.tween_property(self,"position",Vector2(screens[current_screen_index].position.x,0),1.0)


func power_offline():
	if last_power_check:
		last_power_check = false
		$"find letter screen/CanvasLayer".visible = true
		disable_letters.emit()

func power_online():
	if !last_power_check:
		$"find letter screen".reset_board()
		last_power_check = true
		$"find letter screen/CanvasLayer".visible = false
		enable_letters.emit()


func signal_update_password_display(text:String):
	update_password_display.emit(text)
