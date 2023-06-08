# This Script controls the DualShoter weapon, the player's primary weapon, it fires singular projectiles. 



extends "res://Scripts/WeaponBase.gd"

var BULLET = preload("res://Scenes/Projectiles/DualShotP.tscn")
var FLASH = preload("res://Scenes/Effects/muzzleFlashE.tscn")

func _ready():
    firingSpeed = 5
    


func fire(target = Vector2.ZERO):
    if(!canFire):
        return
    self.set_canFire(false)

    muzzle_flash()
    var bullet = BULLET.instance()
    bullet.set_position(global_position)
    bullet.direction = (get_global_mouse_position() - get_tree().root.get_child(0).get_player_position() ).normalized()
    
    
    get_tree().root.get_child(0).add_child(bullet)
    
    
      
func muzzle_flash():
    var flash = $muzzleFlashE.duplicate()
    add_child(flash)
    flash.emitting = true
    yield(get_tree().create_timer(1), "timeout")  
    flash.queue_free()
    
