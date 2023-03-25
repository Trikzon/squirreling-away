extends Node

var rng = RandomNumberGenerator.new()
var Inside=false
var Outside=true

# Called when the node enters the scene tree for the first time.
func _ready():
	$DangerAlmostHere.hide()
	$DangerHere.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_timer_timeout():
	var my_random_number = rng.randi_range(0, 3)
	print(my_random_number)
	if(my_random_number==3):
		$DangerAlmostHere.show()
		$DeathTimer.start()
	else:
		$DangerAlmostHere.hide()


var flag=false
func _on_death_timer_timeout():
	$DangerAlmostHere.hide()
	$DangerHere.show()
	if(Outside==true):
		print("You Died")


func _on_area_3d_body_entered(body):
	Outside=false
	Inside=true


func _on_area_3d_body_exited(body):
	Outside=true
	Inside=false
