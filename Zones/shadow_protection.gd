extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
    $Area3D/MeshInstance3D.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_area_3d_body_entered(body):
    if body is Player:
        body.entershadow(body)


func _on_area_3d_body_exited(body):
    if body is Player:
        body.exitshadow(body)
