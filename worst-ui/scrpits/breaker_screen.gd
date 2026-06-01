extends Node2D


func _ready() -> void:
	GlobalTime.get_node("1sTimer").timeout.connect(_on_5s_timer_timeout)


func _on_5s_timer_timeout():
	var switches:Array = $BreakerButtonsControl/GridContainer.get_children()
	var looping  = true
	var checks = 0
	while looping:
		
		var switch = switches[randi() % switches.size()]
		if switch.button_pressed:
			switch.button_pressed = false
			looping = false
		checks += 1
		if checks > 5:
			looping = false
	
	
	print("5s")

	
