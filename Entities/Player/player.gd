extends CharacterBody3D


@onready var PUSH_RAY_CAST: RayCast3D = $PushRayCast


const SPEED = 5.0
const PUSH_SPEED = 2
const ROTATION_SPEED = 0.1
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var pushing: Pushable = null
var pushing_position: Vector3 = Vector3.ZERO


func _process(delta):
    if Input.is_action_just_pressed("push"):
        if not pushing:
            var collider = PUSH_RAY_CAST.get_collider()
            if collider is Pushable:
                pushing = collider
                collider.reparent(self)
                pushing.set_collision_layer_value(3, false)
                pushing_position = pushing.position
                $hamster_walk_2/AnimationTree.set("parameters/conditions/pushing", true)
                $hamster_walk_2/AnimationTree.set("parameters/conditions/not_pushing", false)
        else:
            $hamster_walk_2/AnimationTree.set("parameters/conditions/pushing", false)
            $hamster_walk_2/AnimationTree.set("parameters/conditions/not_pushing", true)
            pushing.set_collision_layer_value(3, true)
            pushing_position = Vector3.ZERO
            pushing.reparent(get_parent())
            pushing = null
    
    if pushing:
        pushing.position = pushing_position


func _physics_process(delta):
    # Add the gravity.
    if not is_on_floor():
        velocity.y -= gravity * delta

    # Handle Jump.
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = JUMP_VELOCITY

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var input_dir = Input.get_vector("player_left", "player_right", "player_forward", "player_backward")
    var direction = Vector3(input_dir.x, 0, input_dir.y).normalized()
    
    var local_speed
    if pushing:
        local_speed = PUSH_SPEED
    else:
        local_speed = SPEED
    if direction:
        velocity.x = direction.x
        velocity.z = direction.z
        
        if pushing:
            direction = global_position.direction_to(PUSH_RAY_CAST.to_global(PUSH_RAY_CAST.target_position)).round()
            if direction.x == 0:
                velocity.x = 0
            if direction.z == 0:
                velocity.z = 0
        else:
            look_at(Vector3.FORWARD.rotated(Vector3.UP, rotation.y).lerp(direction*-1 , ROTATION_SPEED) + position)
        
        velocity *= local_speed
    else:
        velocity.x = move_toward(velocity.x, 0, local_speed)
        velocity.z = move_toward(velocity.z, 0, local_speed)
        
    if velocity:
        $hamster_walk_2/AnimationTree.set("parameters/conditions/walk", true)
        $hamster_walk_2/AnimationTree.set("parameters/conditions/idle", false)
    else:
        $hamster_walk_2/AnimationTree.set("parameters/conditions/walk", false)
        $hamster_walk_2/AnimationTree.set("parameters/conditions/idle", true)

    move_and_slide()
