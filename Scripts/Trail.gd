#this script controlsthe trail created by strongshot(player secondary fire)
extends Line2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var length = 5
var point = Vector2()
# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
    global_position = Vector2(0,0)
    global_rotation = 0
    
    point  = get_parent().global_position
    add_point(point)

    while get_point_count() > 10:
   
        remove_point(0)
        

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
