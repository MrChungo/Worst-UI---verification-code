extends Node2D


func _ready() -> void:
	GlobalTime.get_node("5sTimer").timeout.connect(_on_5s_timer_timeout)


func _on_5s_timer_timeout():
		
	print("5s")
