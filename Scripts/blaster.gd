# This Script controls the Blaster weapon, it fires singular projectiles. 

# -- TO DO --
# check if it has the abbily to change how often it fires on creation.

extends "res://Scripts/WeaponBase.gd"

var BULLET = preload("res://Scenes/Projectiles/BulletMedium.tscn")

func _ready():
	firingSpeed = 1
	projectiles = 10
	spreadAngle = 10
	speedVariation = 30
   


func _process(delta):
	if(Input.is_action_pressed("jump")):
		fire()
	pass
   

func fire(target):

	if(!canFire):
		return

	set_canFire(false)
   
	for i in range(projectiles):
		var bullet = BULLET.instance()
	   
		bullet.projectileSpeed = 100 + rand_range(-speedVariation, speedVariation)     
		
   
		var aimDirection = ( get_global_mouse_position() - global_position ).normalized()
		bullet.direction = aimDirection.rotated(deg2rad(rand_range(-spreadAngle,spreadAngle)))      
		  
		get_tree().root.get_child(0).add_child(bullet)
		bullet.position = global_position
		

func muzzle_flash():
	pass
