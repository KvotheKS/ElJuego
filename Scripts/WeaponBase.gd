# This is the base node for all Weapons,
# a weapon is a node that controls HOW a entity fires projectiles, 

# -- NEW POSSIBLE WEAPONS -- 
# - Shot gun weapon: fires multiple projectiles in a wave
# - unamed1: fires multiple projectiles with sligtly varied speed and size.

# it would be possible to add all these weapon variations in a single weapon node thats configured on creation, but that would be less organized, and maybe slower.

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
    

