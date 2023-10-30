extends CanvasLayer

signal button_move_player
signal buttom_move_camera

func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if $MoveButton.is_pressed():
			var move_vector = calculate_move_vector(event.position)
			emit_signal("button_move_player", move_vector)
		else:
			var move_vector = Vector3.ZERO
			emit_signal("button_move_player", move_vector)
		
		if $CameraButton.is_pressed():
			var cam_vector = calculate_camera_vector(event.position)
			emit_signal("buttom_move_camera", cam_vector)
		else:
			var cam_vector = Vector3.ZERO
			emit_signal("buttom_move_camera", cam_vector)
		if $ShootButton.is_pressed():
			print("shooting")

func calculate_move_vector(event_position):
	var button_radius = $MoveButton.shape.get_radius()
	var button_center = $MoveButton.position + Vector2(button_radius, button_radius)
	return (event_position - button_center).normalized()

func calculate_camera_vector(event_position):
	var button_radius = $CameraButton.shape.get_radius()
	var button_center = $CameraButton.position + Vector2(button_radius, button_radius)
	return (event_position - button_center)
