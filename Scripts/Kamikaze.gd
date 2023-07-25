extends "res://Scripts/EnemyBase.gd"

var linearSpeed: float = 200
var minSpeed: float = 100
const closeDistance: float = 50.0
var middlePoint: Vector2
var t: float = 1
var isClose: bool = false

var stage 
var player_pos = Vector2(0, 0)

func _ready():
	set_max_health(12)
	pointsOnDeath = 125
	max_speed = 200
	stage = get_tree().get_root().get_node("Test")
	pass

func explode() -> void:
	$KamikazeBlaster.fire()
	handle_hit(health)
	return

func _process(delta):
	player_pos = stage.get_player_position()
	return

func _physics_process(delta):
	if (player_pos == null):
		explode()
		return

	# Slow down when near the player
	if (isClose):
		linearSpeed = clamp(linearSpeed - linearSpeed * delta * 2, minSpeed, linearSpeed)

	# Start countdown when near player
	elif (position.distance_to(player_pos) < closeDistance):
		isClose = true
		$ExplosionTimer.start()
		if !$HitAudio.is_playing():
			$HitAudio.stream = hitAudio
			$HitAudio.play()

	# Rush towards the player when far
	middlePoint = (player_pos + position) / 2
	t = clamp(t - delta / 2, 0, 1)
	var curve = quadratic_bezier(player_pos, middlePoint, position)
	set_velocity((curve - position).normalized() * linearSpeed)
	move()

func quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2):
	var q0 = lerp(p0, p1, t)
	var q1 = lerp(p1, p2, t)
	var r = lerp(q0, q1, t)
	return r

func _on_CountdownTimer_timeout():
	explode()
	return
