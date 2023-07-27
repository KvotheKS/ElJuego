# This Script controls the StrongShoter weapon, the player's secondary weapon, it fires strong singular piercing projectiles, limited by cooldown. 

extends "res://Scripts/WeaponBase.gd"

var BULLET = preload("res://Scenes/Projectiles/StrongShotP.tscn")
var audio = preload("res://Assets/Sounds/shot2.wav")

var fire
func _ready():
    firingSpeed = 0.5
    
    pass # Replace with function body.


func fire(target = Vector2.ZERO):
    
    if(!canFire):
        return
    self.set_canFire(false)
    muzzle_flash()
    
    if !$Audio.is_playing():
        $Audio.stream = audio
        $Audio.play()
    
    var bullet = BULLET.instance()
    bullet.direction = ( get_global_mouse_position() - get_tree().root.get_child(1).get_player_position() ).normalized()
    bullet.position = global_position
    
    get_tree().root.get_child(1).add_child(bullet)


func muzzle_flash():
    var flash = $muzzleFlashE.duplicate()
    add_child(flash)
    flash.emitting = true
    yield(get_tree().create_timer(1), "timeout")  
    flash.queue_free()
