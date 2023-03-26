extends Area3D

var objective_name: String
var won: bool = false

func _on_body_entered(body):
    if body is Pushable:
        if body.name== objective_name:
            won = true
