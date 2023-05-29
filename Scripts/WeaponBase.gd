extends Node2D

#shots per second
var firingSpeed = 1
var canFire = false setget set_canFire  
var projectiles = 1
var spreadAngle = 0
var precision = 100


func _ready():
	
	$cooldown.start()


func _process(delta):

	pass
  
# this function must be defined on inheriting node
func fire():
	assert(false, "define this fucntion on inheriting node")
   
func muzzle_flash():
	assert(false, "define this fucntion on inheriting node")

#not fully implemented
func get_target():
	var target = get_parent().target
	if(target):
		return target
	return null

func set_canFire(val):
	canFire = val
	if(!canFire):
		$cooldown.wait_time = (1.0/firingSpeed)
		$cooldown.start()

func _on_cooldown_timeout():
	canFire = true
	

