# just a Test scene

extends Node2D

# @TODO: For now player collision is layer 1 and world is layer 2
# @TODO: Input Maps use snake_case naming to match GODOT's

# Enemies
var GUARDIAN = preload("res://Scenes/Entities/Enemies/SGuardian.tscn")
var SINGLE_SHOOTER = preload("res://Scenes/Entities/Enemies/SingleShooter.tscn")
var TURRET = preload("res://Scenes/Entities/Enemies/Turret.tscn")
var KAMIKAZE = preload("res://Scenes/Entities/Enemies/Kamikaze.tscn")

const MIN_X = 30
const MIN_Y = 30
const MAX_X = 740
const MAX_Y = 260

var spawnPoints = []
var enemies = []

func _ready() -> void:

    # Set random seed
    rand_seed(OS.get_system_time_msecs())

    # Set possible spawn points
    var top = Vector2(rand_range(MIN_X, MAX_X), MIN_Y)
    var bottom = Vector2(rand_range(MIN_X, MAX_X), MAX_Y)
    var left = Vector2(MIN_X, rand_range(MIN_Y, MAX_Y))
    var right = Vector2(MAX_X, rand_range(MIN_Y, MAX_Y))
    spawnPoints = [top, bottom, left, right]

    # Set possible enemies
    enemies = [GUARDIAN, SINGLE_SHOOTER, TURRET, KAMIKAZE]

    pass

func timeout():
    print("TIMEOUT")
    return

func _process(_delta):

    # Update UI
    if ($Player != null):
        $UI.get_child(0).text = str(GameState.points)
        $UI.get_child(1).get_child(0).value = $Player.health      # Health at 0
        $UI.get_child(1).get_child(1).value = $Player.jetpackHeat # Energy at 1
    else:
        GameState.gameOver = true
        get_tree().change_scene("res://Scenes/Menu.tscn")
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

func _unhandled_input(event):
    if event.is_action_pressed("menu"):
        get_tree().change_scene("res://Scenes/Menu.tscn")
        GameState.points = 0
