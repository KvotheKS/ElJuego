# This Script controls the Blaster weapon, it fires singular projectiles. 

# -- TO DO --
# check if it has the abbily to change how often it fires on creation.

extends "res://Scripts/WeaponBase.gd"

var BULLET = preload("res://Scenes/Projectiles/BulletMedium.tscn")

func _ready():
    pass 


func _process(delta):
    pass
   

func fire():
    projectiles = 1
    spreadAngle = 30
    precision = 1
    
    
    var rng = RandomNumberGenerator.new()
    rng.randomize()

    if(!canFire):
        return
    canFire = false
    $cooldown.start()
    
    for i in range(projectiles):
        var bullet = BULLET.instance()
       
        
#        bullet.projectileSpeed = 200 + rng.randf_range(-speedVariation, speedVariation)     
        
#        bullet.direction = Vector2(1,0).rotated(deg2rad((angle/(projectiles-1))*i-angle/2))   
        bullet.direction = ( get_global_mouse_position() - global_position ).normalized()
   
        
        get_tree().root.get_child(0).add_child(bullet)
        bullet.position = global_position
        

func muzzle_flash():
    pass
