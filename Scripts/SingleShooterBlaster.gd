extends "res://Scripts/WeaponBase.gd"

var BULLET = preload("res://Scenes/Projectiles/BulletMedium.tscn")

func _ready():
	firingSpeed = 1
	projectiles = 1
	spreadAngle = 0
	speedVariation = 0

func _process(delta):
	pass

func fire(target = Vector2.ZERO):

	if(!canFire):
		return
	set_canFire(false)

	var bullet = BULLET.instance()
	bullet.projectileSpeed = 200 + rand_range(-speedVariation, speedVariation)
	bullet.duration = 3 + rand_range(-0.5,0.5) 

	var aimDirection = (target - global_position).normalized()
	bullet.direction = aimDirection

	get_tree().root.get_child(0).add_child(bullet)
	bullet.position = global_position

func muzzle_flash():
	pass
