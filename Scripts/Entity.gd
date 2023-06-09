# This script controls the base node for Entities, it should contain functions that apply for every entity in the game.
# - Player and Enemy inherits from this.

extends KinematicBody2D

export(int) var level: float = 1
# current maximum health value
export(float) var maxHealth: float = 100

# current health value
export(float) var health: float = maxHealth

# how much health is regenerated per second
export(float) var regeneraion: float = 0

# base movement speed
export(float) var moveSpeed = 100

export(float) var mass = 100
# bonus movement speed
export(float) var moveSpeedMultiplier: float = 0

# base shield speed
export(int) var shield = 0


# multiplicative modifier to damage
export(float) var damageMultiplier: float = 0

# multiplicative modifier to area
export(float) var areaMltiplier: float = 0

# multiplicative modifier to projectile speed
export(float) var projectileSpeedMultiplier:  float = 0


var EXPLOSION = preload("res://Scenes/Effects/DeathExplosion.tscn")
var velocity = Vector2.ZERO setget set_velocity
var max_global_speed = 500
var max_speed = 80

export (bool) var invulnerable = false

func _ready():
    pass # Replace with function body.


func move():
    velocity = move_and_slide(velocity)

func _integrate_forces(state):
    pass
    
func _process(delta):
    $HealthBar.value = health
    
func _physics_process(delta):
    pass
    
    
func die():
    var explosion = EXPLOSION.instance()  
    explosion.position = position
    get_tree().root.get_child(0).add_child(explosion)
    
    queue_free()
    


func handle_hit(hit_damage, hit_direction = Vector2.ZERO, hit_mass=0):
    
    if(invulnerable): return
    
    velocity += hit_direction*100*hit_mass/mass        # calculate knockback
    health -= hit_damage 
    health = clamp(health,0,maxHealth)
    if(health == 0):
        die()
    
func set_velocity(value):
    velocity = value.clamped(max_global_speed)
