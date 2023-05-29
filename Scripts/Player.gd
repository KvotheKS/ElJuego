extends "res://Scripts/Entity.gd"


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

func _ready():
	maxHealth = 100
	health = maxHealth
# Called every frame
func _physics_process(delta: float) -> void:
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
	if(Input.is_action_pressed("primary")):
#        $DualShot.fire()    
		$MechRig/Torso/Fshoulder/Farm/Fforearm/Gun/DualShot.fire()

	# If the player can shoot the primary and the secondary at the same time
	# change elif -> if
	elif (Input.is_action_pressed("secondary")):	  
		$MechRig/Torso/Fshoulder/Farm/Fforearm/Gun/StrongShot.fire()

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

		
	if(curScale == 1):
		$MechRig/AnimationPlayer.play("aim")
		$MechRig/AnimationPlayer.seek((aimAngle+12-$MechRig/Torso.rotation_degrees)/-180,true)
		
	else:
	  
		$MechRig/AnimationPlayer.play("aim")
		$MechRig/AnimationPlayer.seek((aimAngle-12+$MechRig/Torso.rotation_degrees)/180,true)
	
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
	if(curScale == 1):
		lookAngle = clamp(aimAngle,-100,-80)
		$MechRig/Torso/Head.rotation_degrees = lookAngle-$MechRig/Torso.rotation_degrees+90
	else:
		lookAngle = clamp(aimAngle,80,100)
		$MechRig/Torso/Head.rotation_degrees = -lookAngle-$MechRig/Torso.rotation_degrees+90

	
	
func calculate_velocity(linearVelocity: Vector2, 
						direction: Vector2,
						delta: float) -> Vector2:

	var outVelocity = linearVelocity

	# Move right
	if direction.x > 0.0:
		outVelocity.x = min(outVelocity.x + _acceleration.x, _maxSpeed.x)

	# Move left
	elif direction.x < 0.0:
		outVelocity.x = max(outVelocity.x - _acceleration.x, -_maxSpeed.x)

	# Stop
	else:
		outVelocity.x = lerp(outVelocity.x, 0.0, _deceleration.x)

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

	return outVelocity

func calculate_jetpack_overheat(overheat: float,
								delay: float,
								cooldownRate: float,
								delta: float) -> float:

	var outHeat = overheat
	jetpackCooldownTimer = min(jetpackCooldownTimer + delta, delay)

	# Jetpack cooldown delay not over yet
	if jetpackCooldownTimer < delay:
		return outHeat

	# Cooldown jetpack until 0 or until next use
	outHeat = max(outHeat - (cooldownRate * delta), 0.0)

	return outHeat




