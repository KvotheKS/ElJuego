extends Node2D

#shots per second
var firingSpeed = 2
var canFire = false 
var firePoint = Vector2()


func _ready():
    $cooldown.wait_time = (1.0/firingSpeed)
    $cooldown.start()


func _process(delta):

    pass
  
# this function must be defined on inheriting node
func fire(count, spread, precision, speedVariation):
    assert(false, "define this fucntion on inheriting node")
   
func muzzle_flash():
    assert(false, "define this fucntion on inheriting node")

#not fully implemented
func get_target():
    var target = get_parent().target
    if(target):
        return target
    return null


func _on_cooldown_timeout():
    canFire = true
    

