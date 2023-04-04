extends KinematicBody2D

var gravity = 4000.0
var speed = Vector2(400.0, 1000.0)
var _velocity = Vector2.ZERO # Private variable

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
	outVelocity.x = speed.x * direction.x
	outVelocity.y += gravity * delta

	if direction.y < 0.0:
		outVelocity.y = speed.y * direction.y

	if isJumpInterrupted:
		outVelocity.y = 0.0

	return outVelocity
