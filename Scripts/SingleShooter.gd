extends "res://Scripts/EnemyBase.gd"

enum {MOVING, ATTACKING, IDLE}
var currentState = IDLE
var stage 
var player_pos = Vector2.ZERO

func _ready():
	set_max_health(20)
	pointsOnDeath = 100
	
	stage = get_tree().get_root().get_node("Test")
	hitAudio = preload("res://Assets/Sounds/Hit2.wav")
	change_state(MOVING)

	max_speed = 160
	pass 

func _physics_process(delta):
	move()

func _process(delta):
	player_pos = stage.get_player_position()
	if (player_pos == null):
		return

	$Sprite.rotation_degrees = clamp(velocity.x*0.2,-10,10)
	match currentState:
		MOVING:
			process_moving(delta)  
		ATTACKING:
			process_attacking()

func change_state(newState):
	currentState = newState

	match currentState:
		MOVING:
			pass
		ATTACKING:
			pass

# Stays a healthy distance from the player and shoot.
func process_moving(delta):

	# Change the desired distance to the player here
	var target_pos = player_pos + Vector2(250, -50);
	if (velocity.length() < 80):
		var distance = target_pos.distance_to(self.position)
		var direction = (target_pos - self.position).normalized() 
		set_velocity(velocity + direction * 100 * delta)

	else:   
		set_velocity(velocity - velocity.normalized() * 200 * delta)

func process_charging(delta):  
	set_velocity(velocity - velocity.normalized() * 60 * delta)
	pass

# Change the desired target here
func process_attacking():

	# Targets the player
	var target = player_pos;
	
	# Targets the player vertical/horizontal axis only
	# target.y = self.position.y;
	# target.x = self.position.x;
	
	$SingleShooterBlaster.fire(target)
	pass

func _on_StateTimer_timeout():
	match currentState:
		MOVING:
			change_state(ATTACKING)
			$StateTimer.start(0.1)

		ATTACKING:
			change_state(MOVING) 
			$StateTimer.start(2.5)
