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

var deathEffect = preload("res://Scenes/Effects/BulletBlastE.tscn")

func _ready():
    $Duration.wait_time = duration
    pass # Replace with function body.

func _process(delta):
    pass

func UpdateStats():
    damage = baseDamage 
    
    var l_scale = 1
    
    $CollisionShape2D.scale = Vector2(l_scale,l_scale)
    #$AnimatedSprite.scale = Vector2(l_scale,l_scale)
    

func die():
    death()
    queue_free()


func death():
    if(deathEffect):
        var deinstance = deathEffect.instance()
        deinstance.position = position
        get_parent().add_child(deinstance)
    
func hanlde_hit():
    if(pierce > 0):
        pierce -= 1
    else:
        die()


func _on_Duration_timeout():
    die()
    
