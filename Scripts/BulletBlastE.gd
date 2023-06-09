extends AnimatedSprite

func _ready():
    play("default")
    $Tween.interpolate_property(self, "modulate:a", 1.0, 0.0, 0.4)
    $Tween.start()
    
    

func _on_AnimatedSprite_animation_finished():
    queue_free()
