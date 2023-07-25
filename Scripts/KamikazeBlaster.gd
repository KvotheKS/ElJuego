extends "res://Scripts/WeaponBase.gd"

var BULLET = preload("res://Scenes/Projectiles/BulletMedium.tscn")

var projectileSpeed = 75
var projectileDuration = 0.95

func _ready():
	projectiles = 15

func _process(delta):
	pass

func fire(target = Vector2.ZERO):

	if(!canFire):
		return
	set_canFire(false)

	# Fire projectiles in a radius
	for i in range(projectiles):
		var bullet = BULLET.instance()
		var spread = i * (360 / projectiles)

		bullet.projectileSpeed = projectileSpeed
		bullet.duration = projectileDuration

		var aimDirection = (target - global_position).normalized()
		bullet.direction = aimDirection.rotated(deg2rad(spread))      

		get_tree().root.get_child(0).add_child(bullet)
		bullet.position = global_position

func muzzle_flash():
	pass
