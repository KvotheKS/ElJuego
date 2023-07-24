# This controls the node for the enemy type Turret
# - if any function shows up here and on other enemy type it should probably be in EnemyBase.

# It is a static enemy that the player can plataform above without taking damage and fires at player position.

# -- TO DO --
# - restore ability to actually fire at the player
# - add sprites and aim animation.


extends "res://Scripts/EnemyBase.gd"

const _bulletPath = preload("res://Scenes/Projectiles/BulletMedium.tscn")

var _shotsPerSecond = 5
var _cooldownTimer = 1.0
var stage

func _ready():
	maxHealth = 25
	pointsOnDeath = 100
	stage = get_tree().get_root().get_node("Test")
	hitAudio = preload("res://Assets/Sounds/Hit3.wav")

	pass

func _process(delta):

	# Turret always looks at the player
	var playerPosition = stage.get_player_position()

	if (playerPosition == null):
		return

	$Node2D.look_at(playerPosition)

	_cooldownTimer += delta
	if _cooldownTimer >= 1.0 / _shotsPerSecond:
		_cooldownTimer = 0

	else:
		shoot(playerPosition)

func shoot(target: Vector2):

	# Create a bullet
	var bullet = _bulletPath.instance()
	get_parent().add_child(bullet)

	# Shoot the target
	bullet.position = $Node2D/Position2D.global_position
	var angle = (target - bullet.position).angle_to(bullet.position)
 
	return
