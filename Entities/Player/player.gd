extends CharacterBody3D


@onready var PUSH_RAY_CAST: RayCast3D = $PushRayCast


const SPEED = 5.0
const ROTATION_SPEED = .2
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var pushing: Pushable = null

func _process(delta):
    if Input.is_action_just_pressed("push"):
        if not pushing:
            var collider = PUSH_RAY_CAST.get_collider()
            if collider is Pushable:
                pushing = collider
                collider.reparent(self)
        else:
            pushing.reparent(get_parent())
            pushing = null


func _physics_process(delta):
    # Add the gravity.
    if not is_on_floor():
        velocity.y -= gravity * delta

    # Handle Jump.
    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        velocity.y = JUMP_VELOCITY

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var input_dir = Input.get_vector("player_left", "player_right", "player_forward", "player_backward")
    var direction = Vector3(input_dir.x, 0, input_dir.y).normalized()
    if direction:
        velocity.x = direction.x * SPEED
        velocity.z = direction.z * SPEED
        
        look_at(Vector3.FORWARD.rotated(Vector3.UP, rotation.y).lerp( direction*-1 , ROTATION_SPEED) + position)
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)
        velocity.z = move_toward(velocity.z, 0, SPEED)
        
    if velocity:
        $hamster_walk_2/AnimationTree.set("parameters/conditions/walk", true)
        $hamster_walk_2/AnimationTree.set("parameters/conditions/idle", false)
    else:
        $hamster_walk_2/AnimationTree.set("parameters/conditions/walk", false)
        $hamster_walk_2/AnimationTree.set("parameters/conditions/idle", true)

    move_and_slide()
