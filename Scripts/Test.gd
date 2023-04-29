extends Node2D

# @TODO: For now player collision is layer 1 and world is layer 2
# @TODO: Input Maps use snake_case naming to match GODOT's

func _ready() -> void:
    pass

# Sends player position to the turret
func _process(_delta):
#    $Turret._playerPosition = $Player.position
    $Turret._playerPosition = Vector2(200,200)
