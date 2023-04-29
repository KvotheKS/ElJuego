extends Area2D

var _velocity = Vector2(0, 0)
var _speed = 300

func _physics_process(delta):
    position += _velocity * delta
    return

# Delete bullet on collision
func _on_TurretBullet_body_entered(body):
    queue_free()
    return
