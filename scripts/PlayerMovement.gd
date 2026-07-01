extends CharacterBody3D

const ACCEL_DEFAULT = 10 # Normal acceleration
const ACCEL_AIR = 1 # Acceleration in air
@onready var accel = ACCEL_DEFAULT
var speed = 10.0
var gravity = 20.0
var jump = 8.0
var mouseSensi = 0.1
var rotationSpeed = 4.0
var direction = Vector3()
var mouseCaptured = true

func captureMouse():
	if mouseCaptured:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _ready():
	captureMouse()
	floor_snap_length = 0.3 # Replaces the old "snap" vector for slope/step handling

func _input(event):
	if event is InputEventMouseMotion and mouseCaptured:
		rotate_y(deg_to_rad(-event.relative.x * mouseSensi))

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		mouseCaptured = !mouseCaptured
		captureMouse()

func _physics_process(delta):
	var hRot = global_transform.basis.get_euler().y
	var fInput = Input.get_action_strength("mvBackward") - Input.get_action_strength("mvForward")
	var hInput = Input.get_action_strength("mvRight") - Input.get_action_strength("mvLeft")

	if mouseCaptured:
		if Input.is_action_pressed("rotLeft"):
			rotate_y(deg_to_rad(rotationSpeed))
		elif Input.is_action_pressed("rotRight"):
			rotate_y(deg_to_rad(-rotationSpeed))
	else:
		fInput = 0
		hInput = 0

	direction = Vector3(hInput, 0, fInput).rotated(Vector3.UP, hRot).normalized()

	if is_on_floor():
		accel = ACCEL_DEFAULT
	else:
		accel = ACCEL_AIR
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("mvJump") and is_on_floor() and mouseCaptured:
		velocity.y = jump

	var horizontal = Vector3(velocity.x, 0, velocity.z).lerp(direction * speed, accel * delta)
	velocity.x = horizontal.x
	velocity.z = horizontal.z

	move_and_slide()
