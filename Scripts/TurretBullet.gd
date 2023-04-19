extends KinematicBody2D

var _velocity = Vector2(0, 0)
var _speed = 300

func _physics_process(delta):

	# Delete bullet after any collision
	var collisionInfo = move_and_collide(_velocity.normalized() * _speed * delta)
	if collisionInfo:
		queue_free()
