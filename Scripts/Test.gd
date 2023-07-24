# just a Test scene

extends Node2D

# @TODO: For now player collision is layer 1 and world is layer 2
# @TODO: Input Maps use snake_case naming to match GODOT's

var GUARDIAN = preload("res://Scenes/Entities/Enemies/SGuardian.tscn")
var SINGLE_SHOOTER = preload("res://Scenes/Entities/Enemies/SingleShooter.tscn")
var TURRET = preload("res://Scenes/Entities/Enemies/Turret.tscn")

const MIN_X = 30
const MIN_Y = 30
const MAX_X = 540
const MAX_Y = 260

var spawnPoints = []
var enemies = []

func _ready() -> void:

	# Set random seed
	rand_seed(OS.get_system_time_msecs())

	# Set possible spawn points
	var top = Vector2(rand_range(MIN_X, MAX_X), MIN_Y)
	var bottom = Vector2(rand_range(MIN_X, MAX_X), MAX_Y)
	var left = Vector2(0, rand_range(MIN_Y, MAX_Y))
	var right = Vector2(MAX_X, rand_range(MIN_Y, MAX_Y))
	spawnPoints = [top, bottom, left, right]

	# Set possible enemies
	enemies = [GUARDIAN, SINGLE_SHOOTER]

	pass

func timeout():
	print("TIMEOUT")
	return

func _process(_delta):

	# Update score label
	$Score.text = str(GameState.points)
	pass
  
func get_player_position():
	if($Player): 
		return $Player.position
	else:
		return null

# Spawn more enemies
func _on_SpawnTimer_timeout():

	# Choose a random spawn point
	var spawnPoint = spawnPoints[randi() % 4]

	# Choose a random enemy to spawn
	var enemy = enemies[randi() % enemies.size()].instance()
	enemy.position = spawnPoint

	add_child(enemy)
	return
