extends "res://Scripts/ProjectileBase.gd"


var deathEffect = preload("res://Scenes/Effects/BulletBlastE.tscn")

func _ready():
    $TowardtMB.init(projectileSpeed)
    pass # Replace with function body.


func death():
    if(deathEffect):
        var deinstance = deathEffect.instance()
        deinstance.position = position
        get_parent().add_child(deinstance)
