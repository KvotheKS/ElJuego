extends "res://Scripts/MovementBehaviorBase.gd"

var direction
func _ready():
    pass
    
    
func init(_speed):
    speed = _speed
    
func _physics_process(delta):

    direction = get_parent().direction
    if(get_parent() is Area2D):
        get_parent().global_position += direction * speed * delta
        
    else:
        get_parent().velocity += speed*direction



