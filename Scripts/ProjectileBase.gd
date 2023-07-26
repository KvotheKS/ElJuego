# This Script controls the behavior of all projectiles.

# -- TO DO --
# - abily to increase damage based on parent weapon level, for enemy variations and, for player power level

extends Area2D

var direction = Vector2(1,0)
var target = null
# base damage of all projectiles
export var baseDamage = 25.0
var damage = baseDamage

# base projectile speed of all projectiles
export var baseProjectileSpeed = 200
var projectileSpeed = baseProjectileSpeed
export var mass = 50
# base duration of all player projectiles
export(float) var duration: float = 1

# projectile pierce
export(int) var base_pierce: int = 0
var pierce = base_pierce

# multiplicative modifier to duration
export(float) var durationMultiplier: float = 0

var velocity = Vector2.ZERO setget set_velocity
var max_global_speed = 5000
var max_speed = 80

#var deathEffect = preload("res://Scenes/Effects/BulletBlastE.tscn")
var canHit = true

func _ready():
	$Duration.start(duration)
	
func _process(delta):
	rotation = direction.angle()
	if not $VisibilityNotifier2D.is_on_screen():
		queue_free()
	
func _physics_process(delta):
	move(delta)
	canHit=true
	
##################
# Base Functions #
##################
func UpdateStats():
	damage = baseDamage 
#    var l_scale = 1
#
#    $CollisionShape2D.scale = Vector2(l_scale,l_scale)

func move(delta):
	global_position += velocity*delta
	

	
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
	

func _on_ProjectileBase_body_entered(body): #for hiting terrain
	die()


func die():
	death()
	queue_free()
	
func handle_hit():
	if(pierce > 0):
		pierce -= 1
	else:
		die()
		
func _on_ProjectileBase_area_entered(area): #for hitting entities

	if(!canHit):
		return
	canHit = false
	
	handle_hit()
	var hit_direction = ((area.global_position - self.global_position).normalized() + self.velocity.normalized()).normalized()
	area.get_parent().handle_hit(damage, hit_direction, mass)

func set_velocity(value):
	velocity = value
	velocity = velocity.limit_length(max_global_speed)
