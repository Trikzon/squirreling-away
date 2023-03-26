extends Camera3D

@export var player: CharacterBody3D

const X_SPEED = .05
const X_RADIUS = 2.5

const Y_OFFSET = 4
const Y_SPEED = .2
const Y_RADIUS = 4


func _ready():
    position.x = player.position.x
    position.y = player.position.y + Y_OFFSET


func _process(delta):
    if abs(position.x - player.position.x) > X_RADIUS:
        position.x = move_toward(position.x, player.position.x, X_SPEED)
    
    if abs(position.y - Y_OFFSET - player.position.y) > Y_RADIUS:
        position.y = move_toward(position.y, player.position.y, Y_SPEED)
