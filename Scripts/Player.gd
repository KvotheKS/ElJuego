extends KinematicBody2D

const _gravity = -4000.0
const _speed = Vector2(400.0, 1000.0)
const _acceleration = Vector2(20.0, 0.0)
const _deceleration = Vector2(0.15, 0.0) # Range between [0.0, 1.0]
var _velocity = Vector2.ZERO

# Called every frame
func _physics_process(delta: float) -> void:
	var isJumpInterrupted = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction = get_direction()

	_velocity = calculate_velocity(_velocity, direction, isJumpInterrupted, delta)
	_velocity = move_and_slide(_velocity, Vector2.UP)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if (Input.is_action_just_pressed("jump") and is_on_floor()) else 1.0
	)

func calculate_velocity(linearVelocity: Vector2, 
						direction: Vector2,
						isJumpInterrupted: bool,
						delta: float) -> Vector2:

	var outVelocity = linearVelocity

	# Move right
	if direction.x > 0.0:
		outVelocity.x = min(outVelocity.x + _acceleration.x, _speed.x)

	# Move left
	elif direction.x < 0.0:
		outVelocity.x = max(outVelocity.x - _acceleration.x, -_speed.x)

	# Stop
	else:
		outVelocity.x = lerp(outVelocity.x, 0.0, _deceleration.x)

	# Jump
	if direction.y > 0.0:
		outVelocity.y -= _gravity * delta

	# Fall
	if direction.y < 0.0:
		outVelocity.y = _speed.y * direction.y

	if isJumpInterrupted:
		outVelocity.y = 0.0

	return outVelocity
