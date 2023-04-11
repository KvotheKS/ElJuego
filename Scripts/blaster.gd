extends "res://Scripts/WeaponBase.gd"

var BULLET = preload("res://Scenes/Projectiles/BulletMedium.tscn")
func _ready():
    
    pass # Replace with function body.


func _process(delta):
    pass


func fire(projectiles = 10, angle = 30, precision = 1, speedVariation = 40,durationVariation = 0.1):
    var rng = RandomNumberGenerator.new()
    rng.randomize()

    if(!canFire):
        return
    canFire = false
    $cooldown.start()
    for i in range(projectiles):
        var bullet = BULLET.instance()
        bullet.position = position
        
        bullet.projectileSpeed = 200 + rng.randf_range(-speedVariation, speedVariation)
        
        bullet.get_node("Duration").wait_time += rng.randf_range(-durationVariation, durationVariation)
        
        bullet.direction = Vector2(1,0).rotated(deg2rad((angle/(projectiles-1))*i-angle/2))
        get_parent().add_child(bullet)
    
    

func muzzle_flash():
    pass
