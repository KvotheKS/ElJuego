extends Node2D

# @TODO: For now player collision is layer 1 and world is layer 2
# @TODO: Input Maps use snake_case naming to match GODOT's

func _ready() -> void:
    pass

func _physics_process(delta):
    $Sprite.position.x = get_global_mouse_position().x
    $Sprite.position.y = get_global_mouse_position().y
    
    $Sprite2.position = $Player.global_position
 
