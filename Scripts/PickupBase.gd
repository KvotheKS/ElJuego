extends Node2D

func _ready():
	$Timer.start()
	return

func _on_Area2D_area_entered(area):

	# Only the Player can collect the pickup
	if (area.name == "HurtBox"):
		queue_free()
	pass

# Do nothing if hit by a projectile
func handle_hit(_hit_damage = 0, _hit_direction = Vector2.ZERO, _hit_mass = 0):
	return

# Vanishes after the time expires
func _on_Timer_timeout():
	queue_free()
	pass
