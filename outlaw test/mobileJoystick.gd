extends CanvasLayer

signal button_move_player

func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if $TouchScreenButton.is_pressed():
			var move_vector = calculate_move_vector(event.position)
			emit_signal("button_move_player", move_vector)

func calculate_move_vector(event_position):
	var button_radius = $TouchScreenButton.shape.get_radius()
	var button_center = $TouchScreenButton.position + Vector2(button_radius, button_radius)
	return (event_position - button_center).normalized()
