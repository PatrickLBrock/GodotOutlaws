extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75

var mouseMovement = Vector2.ZERO

var target_velocity = Vector3.ZERO

@export var CameraNode : Node3D



func _physics_process(delta):
	
	print(Quaternion($CameraYAxis/CameraXAxis.basis).x)
	
	$CameraYAxis/CameraXAxis/CharCamera.look_at(position)
	
	var direction = Vector3.ZERO
	
	var input_direction = Input.get_vector("move_left","move_right","move_forward","move_back")

	direction = ($CameraYAxis.basis * Vector3(input_direction.x, 0,input_direction.y)).normalized()

	#$LookNode.look_at(position + direction, Vector3.UP)

	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)

	# Moving the Character
	#print(target_velocity)
	velocity = target_velocity
	move_and_slide()
	
func cameraMove(mouseVec):
	#rotate camera left and right
	$CameraYAxis.rotate(Vector3(0,1,0), -mouseVec.x / 5000)
	#rotate camera up and down
	#if($CameraYAxis/CameraXAxis.basis.x > -38):
	#print(mouseVec.y)
	if mouseVec.y > 0 && Quaternion($CameraYAxis/CameraXAxis.basis).x < 0.3:
		print("down")
		$CameraYAxis/CameraXAxis.rotate(Vector3(1,0,0), mouseVec.y / 6000)
	elif mouseVec.y < 0 && Quaternion($CameraYAxis/CameraXAxis.basis).x > -0.45:
		$CameraYAxis/CameraXAxis.rotate(Vector3(1,0,0), mouseVec.y / 6000)
	else:
		print("no verti al movement")
	#$CameraYAxis/CameraXAxis.rotate(Vector3(1,0,0), mouseVec.y / 6000)

func _input(event):
	if event is InputEventMouseMotion:
		mouseMovement = event.velocity
		cameraMove(mouseMovement)

