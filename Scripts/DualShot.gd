# This Script controls the behavior for the DualShot Projectile.
# - inherits from ProjectileBase, if any function shows up here it should probably be on Projectile Base.

# Dual Shot is the Projectile for The primary player weapon.
# it's an weaker projectile that can't pierce anything

extends "res://Scripts/ProjectileBase.gd"


var deathEffect = preload("res://Scenes/Effects/SpriteBased/BulletBlastE.tscn")

func _ready():
    pierce = 1
    damage = 10
    projectileSpeed = 1000
    $TowardtMB.init(projectileSpeed)
    pass # Replace with function body.


    
func death():
    if(deathEffect):
        var deinstance = deathEffect.instance()
        deinstance.position = position
        get_tree().root.get_child(0).add_child(deinstance)
