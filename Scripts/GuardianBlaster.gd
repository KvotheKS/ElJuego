

extends "res://Scripts/WeaponBase.gd"

var BULLET = preload("res://Scenes/Projectiles/BulletMedium.tscn")


func _ready():
	firingSpeed = 1
	projectiles = 10
	spreadAngle = 10
	speedVariation = 30
   


func _process(delta):
	pass
   

func fire(target = Vector2.ZERO):

	if(!canFire):
		return
	set_canFire(false)
   
	
	for i in range(projectiles):
		var bullet = BULLET.instance()
		var spread = rand_range(-spreadAngle,spreadAngle)
		bullet.projectileSpeed = 200 + rand_range(-speedVariation, speedVariation)  - abs(spread)*10
		bullet.duration = 1 + rand_range(-0.5,0.5) 
   
		var aimDirection = ( target - global_position ).normalized()
		bullet.direction = aimDirection.rotated(deg2rad(spread))      
		  
		get_tree().root.get_child(0).add_child(bullet)
		bullet.position = global_position
		

func muzzle_flash():
	pass
