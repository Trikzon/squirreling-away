extends Node

var rng = RandomNumberGenerator.new()
var Inside=false
var Outside=true
var my_random_number

# Called when the node enters the scene tree for the first time.
func _ready():
    $Control.hide()
    my_random_number = rng.randi_range(10, 20)
    $RandomTimer.wait_time=my_random_number
    $RandomTimer.start()
    $Spotlight.hide()
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass



func _on_timer_timeout():
    $Control.show()
    $Spotlight.show()
    $InbetweenTimer.start()
        
        
    my_random_number = rng.randi_range(10, 20)
    $RandomTimer.wait_time=my_random_number
    $RandomTimer.start()

func _on_area_3d_body_entered(body):
    Outside=false
    Inside=true


func _on_area_3d_body_exited(body):
    Outside=true
    Inside=false


func _on_hide_timer_timeout():
    $Control.hide()
    $Light.light_energy=0.25


func _on_inbetween_timer_timeout():
    $HideTimer.start()
    $Spotlight.hide()
    $Light.light_energy=1
    if(Outside==true):
        print("You Died")
