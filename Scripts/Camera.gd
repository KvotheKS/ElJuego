extends Camera2D

var base_vec = Vector2(50,0)
var MAXDIST = 700
var MAXINFLUENCE = 280
var ZOOMCHANGE = 0.2
var initial_relative

var parent
var anchor
var camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    parent = get_parent()
    anchor = Rect2(parent.get_position(), parent.get_node("CollisionShape2D").shape.extents)
    camera = Rect2(
        get_global_position(), 
        Vector2( ProjectSettings.get_setting("display/window/size/width"),
                 ProjectSettings.get_setting("display/window/size/height")
        )
    )
    initial_relative = position
    return # Replace with function body.

func _cubic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, p3: Vector2, t: float) -> Vector2:
    var q0 = lerp(p0, p1, t)
    var q1 = lerp(p1,p2, t)
    var q2 = lerp(p2,p3, t)

    var r0 = lerp(q0,q1, t)
    var r1 = lerp(q1, q2, t)

    var s = lerp(r0, r1, t)
    return s

func mf_curve(t: float) -> float:
    t /= MAXDIST
    var p0 = Vector2(0,0)
    var p1 = Vector2(MAXINFLUENCE*0.4,0)
    var p2 = Vector2(MAXINFLUENCE*0.75, 0)
    var p3 = Vector2(MAXINFLUENCE, 0)
    return _cubic_bezier(p0,p1,p2,p3,t).length()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    anchor.position = parent.get_global_position()
    camera.position = get_global_position()
  
    var mg_pos = get_global_mouse_position()
    
    var diff_vec = mg_pos - anchor.position
    #print(diff_vec)
    #position = initial_relative + (log(min(MAXDIST, diff_vec.length())) / log(1.2)) * diff_vec.normalized()
    var vec_dist = mf_curve(min(MAXDIST, diff_vec.length()))
    position = vec_dist * diff_vec.normalized()
    #zoom = initial_zoom * (1 + (vec_dist/MAXINFLUENCE) * ZOOMCHANGE)
    return
