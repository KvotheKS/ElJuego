extends "res://Scripts/ProjectileBase.gd"


var deathEffect = preload("res://Scenes/Effects/BulletBlastE.tscn")

func _ready():
	damage = 20
	projectileSpeed = 1200
	$TowardtMB.init(projectileSpeed)
	pass # Replace with function body.

func _physics_process(delta):
	print(direction)
	
func death():
	if(deathEffect):
		var deinstance = deathEffect.instance()
		deinstance.position = position
		get_parent().add_child(deinstance)
