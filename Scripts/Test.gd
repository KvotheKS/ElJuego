# just a Test scene

extends Node2D

# @TODO: For now player collision is layer 1 and world is layer 2
# @TODO: Input Maps use snake_case naming to match GODOT's

var GUARDIAN = preload("res://Scenes/Entities/Enemies/SGuardian.tscn")
func _ready() -> void:
	
	for i in range(0):
		var temp = GUARDIAN.instance()
		temp.position.x += rand_range(0,100)
		add_child(temp)
	pass

# Sends player position to the turret
func _process(_delta):
#    $Turret._playerPosition = get_player_position()
	pass
  
func get_player_position():
	if($Player): 
		return $Player.position
	else:
		return null
