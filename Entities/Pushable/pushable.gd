extends RigidBody3D
class_name Pushable

@onready var collision_shape = $CollisionShape3D

func start_freeze():
    freeze = true
    $FreezeTimer.start()


func _on_timer_timeout():
    freeze = false
