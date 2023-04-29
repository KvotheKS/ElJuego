extends Node2D

const _bulletPath = preload("res://Scenes/Projectiles/TurretBullet.tscn")

var _playerPosition = null # Current player position (updated at Test.gd)
var _shotsPerSecond = 5
var _cooldownTimer = 0.0

func _process(delta):

	# Turret always looks at the player
	$Node2D.look_at(_playerPosition)

	_cooldownTimer += delta
	if _cooldownTimer >= 1.0 / _shotsPerSecond:
		_cooldownTimer = 0
		shoot(_playerPosition)

func shoot(target: Vector2):

	# Create a bullet
	var bullet = _bulletPath.instance()
	get_parent().add_child(bullet)

	# Shoot the target
	bullet.position = $Node2D/Position2D.global_position
	var angle = (target - bullet.position).angle_to(bullet.position)
	bullet._velocity = Vector2(bullet._speed, bullet._speed).rotated(-angle)
	return
