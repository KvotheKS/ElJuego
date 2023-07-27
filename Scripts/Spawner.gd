extends Node


var GUARDIAN = preload("res://Scenes/Entities/Enemies/SGuardian.tscn")
var SINGLE_SHOOTER = preload("res://Scenes/Entities/Enemies/SingleShooter.tscn")
var TURRET = preload("res://Scenes/Entities/Enemies/Turret.tscn")

var enemies = []
# Called when the node enters the scene tree for the first time.
func _ready():
	enemies = [GUARDIAN, SINGLE_SHOOTER, TURRET]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
