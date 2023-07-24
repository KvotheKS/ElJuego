# This script controls a standard medium enemy bullet.
# -inherits from ProjectileBase, if any function shows up here it should probably be on Projectile Base.


extends "res://Scripts/ProjectileBase.gd"

var deathEffect = preload("res://Scenes/Effects/SpriteBased/BulletBlastE.tscn")

func _ready():
	$TowardtMB.init(projectileSpeed)
	pass # Replace with function body.


func death():
	if(deathEffect):
		var deinstance = deathEffect.instance()
		deinstance.position = position
		get_parent().add_child(deinstance)
