# This script controsl the node Toward Movement behavior.
# - it causes its parent to move directly in it's direction vector.

extends "res://Scripts/MovementBehaviorBase.gd"

func _ready():
	pass
	
	
func init(_speed):
	speed = _speed
	
func _physics_process(delta):
	get_parent().velocity = speed*direction



