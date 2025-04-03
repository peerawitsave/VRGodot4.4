extends Node3D

@export var move_speed := 4.0
@export var mouse_sensitivity := 0.1

var rotation_y := 0.0
var rotation_x := 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	# Mouse-based head rotation
	var mouse_delta = Input.get_last_mouse_velocity() * mouse_sensitivity * delta
	rotation_y -= mouse_delta.x
	rotation_x = clamp(rotation_x - mouse_delta.y, -80, 80)
	$FakeHead.rotation_degrees = Vector3(rotation_x, rotation_y, 0)

	# Movement
	var dir = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		dir.z += 1
	if Input.is_action_pressed("move_backward"):
		dir.z -= 1
	if Input.is_action_pressed("move_left"):
		dir.x += 1
	if Input.is_action_pressed("move_right"):
		dir.x -= 1

	dir = dir.normalized()
	var basis = $FakeHead.global_transform.basis
	translate((basis.x * dir.x + basis.z * dir.z) * move_speed * delta)
