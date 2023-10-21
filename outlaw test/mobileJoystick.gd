extends CanvasLayer

signal button_move_player

func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if $MoveButton.is_pressed():
			var move_vector = calculate_move_vector(event.position)
			emit_signal("button_move_player", move_vector)
		else:
			var move_vector = Vector3.ZERO
			emit_signal("button_move_player", move_vector)

func calculate_move_vector(event_position):
	var button_radius = $MoveButton.shape.get_radius()
	var button_center = $MoveButton.position + Vector2(button_radius, button_radius)
	return (event_position - button_center).normalized()
