extends "res://Scripts/Entity.gd"

var linearSpeed : float = 200
var minSpeed : float = 150
const closeDistance : float = 150.0
const explosionDamage : int = 10
onready var hero = get_node("../Player")
var initialPos : Vector2
var middlePoint : Vector2
var timer : float = 0
var t : float = 1
var middleSetted : bool = false
var isClose : bool = false

func _ready():
	initialPos = self.position
	
func explode() -> void:
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if(collision.collider.name == "Player"):
			hero.handle_damage(explosionDamage)
	queue_free()

func _physics_process(delta):
	if(hero):
		if(!middleSetted):
			middlePoint = (hero.position + initialPos)/2 - Vector2(0, 150)
			middleSetted = true
			
		if(isClose):
			linearSpeed = clamp(linearSpeed - linearSpeed * delta * 2, minSpeed, linearSpeed)
		elif(self.position.distance_to(hero.position) < closeDistance):
			isClose = true
			
		timer += delta
		if(timer > 4):
			explode()


		t = clamp(t - delta/2, 0, 1)
		var	curve : Vector2 = quadratic_bezier(hero.position, middlePoint, initialPos)
		var v : Vector2 = (curve - self.position).normalized()*linearSpeed

		move_and_slide(v)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if(collision.collider.name == "Player"):
			explode()

func quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2):
	var q0 = lerp(p0, p1, t)
	var q1 = lerp(p1, p2, t)
	var r = lerp(q0, q1, t)
	return r
