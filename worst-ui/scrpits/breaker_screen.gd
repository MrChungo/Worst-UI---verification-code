extends Node2D

signal power_online
signal power_offline

func _ready() -> void:
	GlobalTime.get_node("2sTimer").timeout.connect(_on_5s_timer_timeout)
	$BreakerButtonsControl.connect("button_pressed",on_button_pressed)


func _on_5s_timer_timeout():
	turn_off_random_switch()
	
	power_checks()
	
	
	print("time ticks")

func power_checks():
	if $BreakerButtonsControl.has_deactivated_row():
		power_offline.emit()
		print("power_offline (Row Cleared)")
	elif $BreakerButtonsControl.has_deactivated_column():
		power_offline.emit()
		print("power_offline (Column Cleared)")
	else:
		power_online.emit()
		print("power_online")

func turn_off_random_switch() -> void:
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

func on_button_pressed():
	if randi_range(0,3) == 0:
		turn_off_random_switch()
