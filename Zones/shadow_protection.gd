extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
    $Area3D/MeshInstance3D.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func _on_area_3d_body_entered(body):
    print("Enter")
    if body is Player:
        body.entershadow($Area3D)


func _on_area_3d_body_exited(body):
    print("Exit")
    if body is Player:
        body.exitshadow($Area3D)
