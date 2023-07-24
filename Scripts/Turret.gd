# This controls the node for the enemy type Turret
# - if any function shows up here and on other enemy type it should probably be in EnemyBase.

# It is a static enemy that the player can plataform above without taking damage and fires at player position.

# -- TO DO --
# - restore ability to actually fire at the player
# - add sprites and aim animation.


extends "res://Scripts/EnemyBase.gd"

const _bulletPath = preload("res://Scenes/Projectiles/BulletMedium.tscn")

var _shotsPerSecond = 5
var _cooldownTimer = 0.0
var stage

func _ready():
	maxHealth = 35
	pointsOnDeath = 200
	stage = get_tree().get_root().get_node("Test")
	hitAudio = preload("res://Assets/Sounds/Hit3.wav")

	pass

func _process(delta):

	# Turret always looks at the player
	var playerPosition = stage.get_player_position()

	if (playerPosition == null):
		return

	_cooldownTimer += delta
	if _cooldownTimer >= 1.0 / _shotsPerSecond:
		_cooldownTimer = 0

	else:
		$SingleShooterBlaster.fire(playerPosition)
