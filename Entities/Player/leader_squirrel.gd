extends Node3D


# Called when the node enters the scene tree for the first time.

func _ready():
    
    var anim_player = $AnimationPlayer
    var animations = ['idle']
    
    
    for animation in animations:
        animation = anim_player.get_animation(animation)	
        animation.loop_mode  = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if $AnimationTree.get("parameters/conditions/idle") \
    and not $AnimationTree.get("parameters/conditions/bored") \
    and $boredom_timer.is_stopped():
        $boredom_timer.start()
        print("started")
    
    if $AnimationTree.get("parameters/conditions/walk"):
        $boredom_timer.stop()
        

func _on_boredom_timer_timeout():
    $AnimationTree.set("parameters/conditions/bored", true)
    print("playing")
    $boredom_loop_timer.start()
    
func _on_boredom_loop_timer_timeout():
    $AnimationTree.set("parameters/conditions/bored", false)
