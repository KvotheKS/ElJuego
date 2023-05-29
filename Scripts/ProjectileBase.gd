extends Area2D

var direction = Vector2(1,0)
var target = null
# base damage of all projectiles
export var baseDamage = 25.0
var damage = baseDamage

# base projectile speed of all projectiles
export var baseProjectileSpeed = 200
var projectileSpeed = baseProjectileSpeed

# base duration of all player projectiles
export(float) var duration: float = 1

# projectile pierce
export(int) var base_pierce: int = 0
var pierce = base_pierce

# multiplicative modifier to duration
export(float) var durationMultiplier: float = 0

#var deathEffect = preload("res://Scenes/Effects/BulletBlastE.tscn")

func _ready():
	$Duration.wait_time = duration
	
func _process(delta):
	rotation = direction.angle()
	if not $VisibilityNotifier2D.is_on_screen():
		queue_free()
	
##################
# Base Functions #
##################
func UpdateStats():
	damage = baseDamage 
#    var l_scale = 1
#
#    $CollisionShape2D.scale = Vector2(l_scale,l_scale)

func die():
	death()
	queue_free()
	
func hanlde_hit():
	if(pierce > 0):
		pierce -= 1
	else:
		die()
	
#####################
# Derived Functions #
#####################
# spawn effect of the projectile
func spawn():
	pass
# death effect of the projectile
func death():
	pass


func _on_Duration_timeout():
	die()
	

func _on_ProjectileBase_body_entered(body):
	die()
	
func _on_ProjectileBase_area_entered(area):
	if(area.get_collision_layer() == 1):
		hanlde_hit()
		area.get_parent().handle_damage(damage)
