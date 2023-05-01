extends Node2D

# @TODO: For now player collision is layer 1 and world is layer 2
# @TODO: Input Maps use snake_case naming to match GODOT's

func _ready() -> void:
    pass

# Sends player position to the turret
func _process(_delta):
    $Turret._playerPosition = get_player_position()
  
func get_player_position():
    if($Player): 
        return $Player.position
    else:
        return Vector2(0,0)
