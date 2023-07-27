# This script controls the base node for Movement Behaviors
# - a movement behavior is a node that directly affects the movement of its parent node, such as moving in a direction or moving in waves.
# - it's parent has to have a direction variable that is a Vector2 that points to where the parent sprites is poiting, usually Vector2(1,0) a vector that points to the right.

# -- TO DO --
# - implement duraction timer for MB that don't last for ever.
# - test if assset for parent havin a direction variably is working.

# -- NEW POSSIBLE MOVE BERRAVIORS --
# - waveMB: cause its parent to move in a wave motion, bouncing relative to it's movement direction.
# - shakeMB: cause its parent to shake
# - floatMB: move upward, slows down to zero based on duration

extends Node

export(Vector2) var target = Vector2(0,0) setget set_target
export(int) var speed = 100 setget set_speed
export(int) var maxspeed = 2000
var direction

func _ready():
    # will use direction to orient their movement.
    assert(get_parent().direction != null, "Movement Behavior Parent: " + get_parent().get_name() +" has no attribute direction. " ) # TEST THIS
    direction = get_parent().direction

func set_speed(val):
    if val != speed:
        speed = clamp(val,0,maxspeed)
        
func set_target(val):
    target = val
