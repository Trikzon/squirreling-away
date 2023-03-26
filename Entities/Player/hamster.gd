extends Node3D


# Called when the node enters the scene tree for the first time.

func _ready():
    
    var anim_player = $AnimationPlayer
    var animations = ['idle', 'walk','push','push_idle']
    
    
    for animation in animations:
        animation = anim_player.get_animation(animation)	
        animation.loop_mode  = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		if $AnimationTree.get("parameters/conditions/idle") and $boredom_timer.is_stopped():
			$boredom_timer.start()
			print("started")

func _on_boredom_timer_timeout():
	$AnimationTree.set("parameters/conditions/bored", true)
	$AnimationTree.set("parameters/conditions/idle", false)
	print("playing")
	
