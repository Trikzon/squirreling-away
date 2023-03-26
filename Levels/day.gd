extends Node3D
class_name Day

signal win
signal die

var objective_name: String


func init(objective_name: String):
    self.objective_name = objective_name

func _ready():
    $Kitchen/WinCond.objective_name = objective_name

func _process(delta):
    if $Kitchen/WinCond.won:
        win.emit()
        $Kitchen/WinCond.won = false
    if $Kitchen/Player.died:
        die.emit()
        $Kitchen/Player.died = false
