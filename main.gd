extends Node

@onready var DAY_0_TSCN = preload("res://Levels/day_0.tscn")
@onready var DAY_1_TSCN = preload("res://Levels/day_1.tscn")
@onready var DAY_2_TSCN = preload("res://Levels/day_2.tscn")
@onready var DAY_3_TSCN = preload("res://Levels/day_3.tscn")
@onready var DAY_4_TSCN = preload("res://Levels/day_4.tscn")
@onready var DAY_5_TSCN = preload("res://Levels/day_5.tscn")

const OBJECTIVE_NAMES: Array[String] = ["", "Apple", "Radio", "PepperSpray", "MatchBox", "HulaGirl"]

var level_node: Day
var day = -1


# Called when the node enters the scene tree for the first time.
func _ready():
    $UI.enableStartScreen()

func _process(_delta):
    var temp_day = -1
    if Input.is_action_just_pressed("level_0"):
        temp_day = 0
    if Input.is_action_just_pressed("level_1"):
        temp_day = 1
    if Input.is_action_just_pressed("level_2"):
        temp_day = 2
    if Input.is_action_just_pressed("level_3"):
        temp_day = 3
    if Input.is_action_just_pressed("level_4"):
        temp_day = 4
    if Input.is_action_just_pressed("level_5"):
        temp_day = 5
    if temp_day != -1:
        day = temp_day
        $UI.hideAllScreens()
        start_day()

func _on_dev_level_win():
    $ScoreTimer.stop()

func next_day():
    day += 1
    start_day()

func start_day():
    if level_node:
        level_node.win.disconnect(_on_win)
        level_node.die.disconnect(_on_die)
        level_node.queue_free()
    match day:
        0: level_node = DAY_0_TSCN.instantiate()
        1: level_node = DAY_1_TSCN.instantiate()
        2: level_node = DAY_2_TSCN.instantiate()
        3: level_node = DAY_3_TSCN.instantiate()
        4: level_node = DAY_4_TSCN.instantiate()
        5: level_node = DAY_5_TSCN.instantiate()
        _: print("Error: No level file for day ", day)
    level_node.init(OBJECTIVE_NAMES[day])
    add_child(level_node)
    level_node.win.connect(_on_win)
    level_node.die.connect(_on_die)
    $BeginningPhysicsTimer.start()


func _on_ui_finish_speaking():
    get_tree().paused = false
    if day == 0:
        next_day()


func _on_beginning_physics_timer_timeout():
    $UI.enableDialog(day, OBJECTIVE_NAMES[day])
    get_tree().paused = true


func _on_ui_start_game():
    $UI.hideAllScreens()
    $ScoreTimer.start()
    next_day()


func _on_ui_next_day():
    $UI.hideAllScreens()
    next_day()


func _on_ui_restart_day():
    $UI.hideAllScreens()
    start_day()

func _on_win():
    $UI.enableWinScreen()

func _on_die():
    $UI.enableGameOverScreen()
