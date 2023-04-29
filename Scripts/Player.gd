extends KinematicBody2D

const _gravity = 2500.0
const _speed = Vector2(400.0, 700.0)
const _acceleration = Vector2(20.0, 200.0)
const _deceleration = Vector2(0.15, 0.0) # Range between [0.0, 1.0]

const _jetpackCooldownDelay = 1.5
const _jetpackCooldownRate = 20.0
const _jetpackOverheatRate = 50.0
const _maxJetpackOverheat = 100.0

var _jetpackOverheat = 0.0
var _jetpackCooldownTimer = 0.0

var _isJumpInterrupted = false # Jump with variable height
var _hasJumped = false 

var _velocity = Vector2.ZERO

# Called every frame
func _physics_process(delta: float) -> void:
    _isJumpInterrupted = Input.is_action_just_released("jump") and _velocity.y < 0.0
    var direction = get_direction()

    _velocity = calculate_velocity(_velocity, direction, delta)
    _velocity = move_and_slide(_velocity, Vector2.UP)

    _jetpackOverheat = calculate_jetpack_overheat(_jetpackOverheat,
                                                  _jetpackCooldownDelay,
                                                  _jetpackCooldownRate,
                                                  delta)

    print("Overheat: %.2f" % _jetpackOverheat)

func get_direction() -> Vector2:
    return Vector2(get_horizontal_direction(), get_vertical_direction())

func get_horizontal_direction() -> float:
    return Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

func get_vertical_direction() -> float:
    if Input.is_action_just_pressed("jump") and is_on_floor():
        return -1.0

    else:
        return 1.0

func calculate_velocity(linearVelocity: Vector2, 
                        direction: Vector2,
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

    # Fall
    if direction.y > 0.0:
        outVelocity.y += _gravity * delta

    # Jump
    if direction.y == -1.0:
        outVelocity.y = _speed.y * -1.0

    # Hover
    if (not is_on_floor()) and Input.is_action_pressed("jump") and _hasJumped \
        and _jetpackOverheat < _maxJetpackOverheat:
        outVelocity.y = max(outVelocity.y - _acceleration.y, -_speed.y)
        _jetpackOverheat = min(_jetpackOverheat + (_jetpackOverheatRate * delta), _maxJetpackOverheat)
        _jetpackCooldownTimer = 0.0

    # Stop jumping
    if _isJumpInterrupted:
        _hasJumped = true
        outVelocity.y = 0.0

    # Reset jump
    if is_on_floor():
        _hasJumped = false 

    return outVelocity

func calculate_jetpack_overheat(overheat: float,
                                delay: float,
                                cooldownRate: float,
                                delta: float) -> float:

    var outHeat = overheat
    _jetpackCooldownTimer = min(_jetpackCooldownTimer + delta, delay)

    # Jetpack cooldown delay not over yet
    if _jetpackCooldownTimer < delay:
        return outHeat

    # Cooldown jetpack until 0 or until next use
    outHeat = max(outHeat - (cooldownRate * delta), 0.0)

    return outHeat
