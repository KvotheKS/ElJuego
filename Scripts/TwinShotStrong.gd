# This Script controls the behavior for the Strong Shot Projectile.
# - inherits from ProjectileBase, if any function shows up here it should probably be on Projectile Base.

# Strong Shot is the Projectile for The secondary player weapon.
# a stronger faster moving projectile (or laser if we manage to create it later).

extends "res://Scripts/ProjectileBase.gd"


var deathEffect = preload("res://Scenes/Effects/SpriteBased/BulletBlastE.tscn")

func _ready():
    damage = 20
    projectileSpeed = 2400
    $TowardtMB.init(projectileSpeed)
    pass # Replace with function body.

func _physics_process(delta):
    pass
    
func death():
    if(deathEffect):
        var deinstance = deathEffect.instance()
        deinstance.position = position
        get_parent().add_child(deinstance)
