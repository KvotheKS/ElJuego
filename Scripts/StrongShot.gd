extends "res://Scripts/WeaponBase.gd"

var BULLET = preload("res://Scenes/Projectiles/StrongShotP.tscn")
var fire
func _ready():
    firingSpeed = 2
    
    pass # Replace with function body.


func fire():
    if(!canFire):
        return
    self.set_canFire(false)
    muzzle_flash()
    
    var bullet = BULLET.instance()
    
    bullet.direction = ( get_global_mouse_position() - get_tree().root.get_child(0).get_player_position() ).normalized()
    
    bullet.position = global_position
    
    get_tree().root.get_child(0).add_child(bullet)
    
    
      
      
func muzzle_flash():
    var flash = $muzzleFlashE.duplicate()
    add_child(flash)
    flash.emitting = true
    yield(get_tree().create_timer(1), "timeout")  
    flash.queue_free()
