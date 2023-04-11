extends Node

export(Vector2) var target = Vector2(0,0) setget set_target
export(int) var speed = 100 setget set_speed
export(int) var maxspeed = 2000


func set_speed(val):
    if val != speed:
        speed = clamp(val,0,maxspeed)
        
func set_target(val):
    target = val
