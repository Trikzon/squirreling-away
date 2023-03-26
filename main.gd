extends Node

@onready var DAY_0_TSCN = preload("res://Levels/day_0.tscn")
@onready var DAY_1_TSCN = preload("res://Levels/day_1.tscn")

const OBJECTIVE_NAMES: Array[String] = ["", "Apple", "Radio", "PepperSpray", "MatchBox", "HulaGirl"]

var level_node: Day
var day = -1


# Called when the node enters the scene tree for the first time.
func _ready():
    $ScoreTimer.start()
    next_day()
    

func _on_dev_level_win():
    $ScoreTimer.stop()


func next_day():
    day += 1
    if level_node:
        level_node.queue_free()
    match day:
        0: level_node = DAY_0_TSCN.instantiate()
        1: level_node = DAY_1_TSCN.instantiate()
        _: print("Error: No level file for day ", day)
    level_node.init(OBJECTIVE_NAMES[day])
    add_child(level_node)
    $BeginningPhysicsTimer.start()


func _on_ui_finish_speaking():
    get_tree().paused = false
    if day == 0:
        next_day()


func _on_beginning_physics_timer_timeout():
    $UI.enableDialog(day, OBJECTIVE_NAMES[day])
    get_tree().paused = true
