class_name Player
extends CharacterBody3D

@export var speed: float = 5.0
@export var jump_velocity: float = 4.5
@export var gravity: float = 9.8

func teleport(pos: Vector3) -> void:
	global_position = pos

func _physics_process(delta: float) -> void:
	# Apply gravity when airborne
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get movement input as a 2D vector (x = left/right, y = forward/back)
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_back")

	# Convert to a 3D direction relative to the player's current facing
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
