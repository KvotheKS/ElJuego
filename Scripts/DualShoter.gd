# This Script controls the DualShoter weapon, it fires singular projectiles for the player. 



extends "res://Scripts/WeaponBase.gd"

var BULLET = preload("res://Scenes/Projectiles/DualShotP.tscn")
var fire
func _ready():
    firingSpeed = 5
    
    pass # Replace with function body.


func fire():
    if(!canFire):
        return
    self.set_canFire(false)
    
    
    var bullet = BULLET.instance()
    
    bullet.direction = ( get_global_mouse_position() - get_tree().root.get_child(0).get_player_position() ).normalized()
    
    bullet.position = global_position
    
    get_tree().root.get_child(0).add_child(bullet)
    
    
      
func muzzle_flash():
    pass
