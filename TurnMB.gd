extends "res://Scripts/MovementBehaviorBase.gd"


var direction
var wave = true
# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 100
	
func init(_speed):
	speed = _speed
	
func _physics_process(delta):
	get_parent().direction = get_parent().direction.rotated(deg2rad(speed)*delta)
	

func _on_Timer_timeout():
	wave = !wave
