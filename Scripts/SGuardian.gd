extends "res://Scripts/EnemyBase.gd"

enum {MOVING, ATTACKING,CHARGING,IDLE}
var currentState = IDLE
var stage 
var player_pos = Vector2.ZERO


func _ready():
    set_max_health(30)

    stage = get_tree().get_root().get_node("Test")
    hitAudio = preload("res://Assets/Sounds/Hit1.wav")
    change_state(MOVING)
    
    max_speed = 80
    pass 

func _physics_process(delta):
    move()
    
func _process(delta):
    player_pos = stage.get_player_position()
    if(player_pos == null):
        return
        
    $Sprite.rotation_degrees = clamp(velocity.x*0.2,-10,10)
    match currentState:
        MOVING:
            process_moving(delta)  
        CHARGING:
            process_charging(delta)      
        ATTACKING:
            process_attacking()

func change_state(newState):
    currentState = newState
    
    match currentState:
        MOVING:
            pass
        ATTACKING:
            pass
        CHARGING:
            pass


# When MOVING:
# moves closer when further from maxDesiredDistance
# moves farther when closer than minDesiredDistance
# does not try to stop when inside desired distance causing him to move in a wave

func process_moving(delta):
    
    
    if(velocity.length()<80):
        
        var distance = player_pos.distance_to(self.position)
        var direction = (player_pos - self.position).normalized() if distance > 100 else (self.position - player_pos).normalized()
        set_velocity(velocity + direction * 100 * delta)

    else:   
        set_velocity(velocity - velocity.normalized()*200*delta)
    
    #avoid being under the player
    if(player_pos.y-20 < position.y):
         set_velocity(velocity + Vector2.UP*100*delta)
        
func process_charging(delta):  
    set_velocity(velocity - velocity.normalized()*60*delta)
    pass
    
func process_attacking():
    $GuardianBlaster.fire(player_pos)
    pass


func _on_StateTimer_timeout():  
    match currentState:
        MOVING:
            change_state(CHARGING)
            $StateTimer.start(1)
            
        CHARGING:
            change_state(ATTACKING)
            $StateTimer.start(0.1)
            
        ATTACKING:
            change_state(MOVING) 
            $StateTimer.start(4)
        

