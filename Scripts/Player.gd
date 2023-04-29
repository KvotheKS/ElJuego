extends KinematicBody2D

const _gravity = 2000.0
const _maxSpeed = Vector2(400.0, 500.0)
const _maxFallSpeed = 500
const _acceleration = Vector2(20.0, 200.0)
const _deceleration = Vector2(0.15, 0.0) # Range between [0.0, 1.0]

const _jetPackMaxSpeed = 300
const _jetPackAcceleration = 100
const _jetpackCooldownDelay = 0
const _jetpackCooldownRate = 20.0
const _jetpackHeatRate = 50.0
const _maxJetpackOverheat = 100.0

var jetpackHeat = 0.0
var jetpackCooldownTimer = 0

var isJumpInterrupted = false # Jump with variable height
var hasJumped = true 

var characterLean = 0
var direction = Vector2.ZERO  
var velocity = Vector2.ZERO 

# Called every frame
func _physics_process(delta: float) -> void:
<<<<<<< HEAD
#    print(jetpackHeat)
    isJumpInterrupted = Input.is_action_just_released("jump")
    direction = Input.get_vector("move_left","move_right","ui_up","ui_down")

    velocity = calculate_velocity(velocity, direction, delta)
    velocity = move_and_slide(velocity, Vector2.UP)
    
    jetpackHeat = calculate_jetpack_overheat(jetpackHeat,
                                                  _jetpackCooldownDelay,
                                                  _jetpackCooldownRate,
                                                  delta)
                                                
    animate(delta)  
func _process(delta):
    pass  
    
func animate(delta):
    var curScale = $MechRig.scale.x
    var cursorPos = get_global_mouse_position()
    var playerPos = global_position
    
    if(cursorPos < playerPos):
        if curScale ==  1:
            characterLean = 0.5
        $MechRig.scale.x = -1
    else:
        if curScale ==  -1:
            characterLean = -0.5
        $MechRig.scale.x = 1 
    
    if(direction.x > 0): characterLean = min(characterLean+(5*delta),1)
    elif(direction.x < 0): characterLean = max(characterLean-(5*delta),-1)
    else:
        if(characterLean>0): characterLean = max(characterLean-(3*delta),0)
        else: characterLean = min(characterLean+(3*delta),0)
    
    

    var aimVector = cursorPos - playerPos
    aimVector = aimVector.rotated(deg2rad(-90))
    var aimAngle = rad2deg(atan2(aimVector.y, aimVector.x))
    
    
    
=======
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
>>>>>>> feat/enemy_turret

        
    if(curScale == 1):
        $MechRig/AnimationPlayer.play("aim")
        $MechRig/AnimationPlayer.seek((aimAngle+22-$MechRig/Torso.rotation_degrees)/-180,true)
        
    else:
      
        $MechRig/AnimationPlayer.play("aim")
        $MechRig/AnimationPlayer.seek((aimAngle-22+$MechRig/Torso.rotation_degrees)/180,true)
    
    if(!is_on_floor()):
        $MechRig/AnimationPlayer.play("MoveUpward")
        $MechRig/AnimationPlayer.seek(velocity.y/_maxFallSpeed*2+0.5,true)
    else:   
        if(characterLean<0):
            if($MechRig.scale.x>0):$MechRig/AnimationPlayer.play("moveBackward")
            else:   $MechRig/AnimationPlayer.play("moveFoward")
            
            $MechRig/AnimationPlayer.seek(characterLean*-1,true)
            $MechRig/AnimationPlayer.stop()
        else:
            if($MechRig.scale.x<0):$MechRig/AnimationPlayer.play("moveBackward")
            else:   $MechRig/AnimationPlayer.play("moveFoward")
            
            $MechRig/AnimationPlayer.seek(characterLean,true)
            $MechRig/AnimationPlayer.stop()
            
    var lookAngle 
    print(aimAngle)
    if(curScale == 1):
        lookAngle = clamp(aimAngle,-100,-80)
        $MechRig/Torso/Head.rotation_degrees = lookAngle-$MechRig/Torso.rotation_degrees+90
    else:
        lookAngle = clamp(aimAngle,80,100)
        $MechRig/Torso/Head.rotation_degrees = -lookAngle-$MechRig/Torso.rotation_degrees+90
#    if is_on_floor() and hasJumped:
#        $MechRig/AnimationPlayer.play("RESET")
    
    
func calculate_velocity(linearVelocity: Vector2, 
                        direction: Vector2,
                        delta: float) -> Vector2:

    var outVelocity = linearVelocity

    # Move right
    if direction.x > 0.0:
<<<<<<< HEAD
        outVelocity.x = min(outVelocity.x + _acceleration.x, _maxSpeed.x)

    # Move left
    elif direction.x < 0.0:
        outVelocity.x = max(outVelocity.x - _acceleration.x, -_maxSpeed.x)
=======
        outVelocity.x = min(outVelocity.x + _acceleration.x, _speed.x)

    # Move left
    elif direction.x < 0.0:
        outVelocity.x = max(outVelocity.x - _acceleration.x, -_speed.x)
>>>>>>> feat/enemy_turret

    # Stop
    else:
        outVelocity.x = lerp(outVelocity.x, 0.0, _deceleration.x)

<<<<<<< HEAD
    # Fall 
    outVelocity.y = min(outVelocity.y+_gravity*delta,_maxFallSpeed)
        
    
    # Jump
    if Input.is_action_just_pressed("jump") and is_on_floor():
        outVelocity.y = _maxSpeed.y * -1.0

    # Hover
    if (not is_on_floor()) and Input.is_action_pressed("jump") and hasJumped \
        and jetpackHeat < _maxJetpackOverheat:
        outVelocity.y = max(outVelocity.y - _jetPackAcceleration, -_jetPackMaxSpeed)
        jetpackHeat = min(jetpackHeat + (_jetpackHeatRate * delta), _maxJetpackOverheat)
        jetpackCooldownTimer = 0.0

    # Stop jumping
    if isJumpInterrupted:
        hasJumped = true
        outVelocity.y = 0.0

    # Reset jump
    if is_on_floor():
        hasJumped = false 

=======
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

>>>>>>> feat/enemy_turret
    return outVelocity

func calculate_jetpack_overheat(overheat: float,
                                delay: float,
                                cooldownRate: float,
                                delta: float) -> float:

    var outHeat = overheat
<<<<<<< HEAD
    jetpackCooldownTimer = min(jetpackCooldownTimer + delta, delay)

    # Jetpack cooldown delay not over yet
    if jetpackCooldownTimer < delay:
=======
    _jetpackCooldownTimer = min(_jetpackCooldownTimer + delta, delay)

    # Jetpack cooldown delay not over yet
    if _jetpackCooldownTimer < delay:
>>>>>>> feat/enemy_turret
        return outHeat

    # Cooldown jetpack until 0 or until next use
    outHeat = max(outHeat - (cooldownRate * delta), 0.0)
<<<<<<< HEAD

    return outHeat

=======

    return outHeat
>>>>>>> feat/enemy_turret
