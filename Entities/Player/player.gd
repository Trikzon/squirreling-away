extends CharacterBody3D
class_name Player


@onready var LOOK_DIRECTION: RayCast3D = $LookDirection


const SPEED = 5.0
const PUSH_SPEED = 2
const ROTATION_SPEED = 0.1
const JUMP_VELOCITY = 8

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var closest_pushable: Pushable = null

var closest_shadow: Area3D = null

var pushing: Pushable = null
var pushing_position: Vector3 = Vector3.ZERO
var pushing_collision: CollisionShape3D = null


func _process(_delta):
    if Input.is_action_just_pressed("push") and is_on_floor():
        if not pushing:
            if closest_pushable:
                pushing = closest_pushable
                closest_pushable.reparent(self)
                pushing_collision = pushing.collision_shape.duplicate()
                add_child(pushing_collision)
                pushing.collision_shape.disabled = true
                pushing_position = pushing.position
                $hamster_walk_2/AnimationTree.set("parameters/conditions/pushing", true)
                $hamster_walk_2/AnimationTree.set("parameters/conditions/not_pushing", false)
        else:
            $hamster_walk_2/AnimationTree.set("parameters/conditions/pushing", false)
            $hamster_walk_2/AnimationTree.set("parameters/conditions/not_pushing", true)
            pushing_position = Vector3.ZERO
            pushing.collision_shape.disabled = false
            pushing.start_freeze()
            pushing_collision.queue_free()
            pushing_collision = null
            pushing.reparent(get_parent())
            pushing = null
    
    if pushing:
        pushing.position = pushing_position
        pushing_collision.position = pushing_position


func _physics_process(delta):
    # Add the gravity.
    if not is_on_floor():
        velocity.y -= gravity * delta

    if is_on_floor():
        $hamster_walk_2/AnimationTree.set("parameters/conditions/jump", false)
        $hamster_walk_2/AnimationTree.set("parameters/conditions/not_jump", true)

    # Handle Jump.
    if Input.is_action_just_pressed("jump") and is_on_floor() and not pushing:
        velocity.y = JUMP_VELOCITY
        $hamster_walk_2/AnimationTree.set("parameters/conditions/jump", true)
        $hamster_walk_2/AnimationTree.set("parameters/conditions/not_jump", false)

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var input_dir = Input.get_vector("player_left", "player_right", "player_forward", "player_backward")
    var direction = Vector3(input_dir.x, 0, input_dir.y).normalized()
    var look_direction = Vector3.ZERO
    
    var local_speed
    if pushing:
        local_speed = PUSH_SPEED
        
        LOOK_DIRECTION.target_position = pushing_position
        look_direction = global_position.direction_to(LOOK_DIRECTION.to_global(LOOK_DIRECTION.target_position)).round()
        if look_direction.x != 0 and look_direction.z != 0:
                look_direction.z = 0
        var old_rotation = rotation.y
        var old_pushing_rotation = pushing.global_rotation
        look_at(Vector3.FORWARD.rotated(Vector3.UP, rotation.y).lerp(look_direction * -1, ROTATION_SPEED) + position)
        pushing_position = pushing_position.rotated(Vector3.UP, old_rotation - rotation.y)
        pushing.global_rotation = old_pushing_rotation
    else:
        local_speed = SPEED
    
    if direction:
        velocity.x = direction.x * local_speed
        velocity.z = direction.z * local_speed
        
        if pushing:
            if look_direction.x == 0:
                velocity.x = 0
            if look_direction.z == 0:
                velocity.z = 0
        else:
            look_at(Vector3.FORWARD.rotated(Vector3.UP, rotation.y).lerp(direction * -1, ROTATION_SPEED) + position)
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


func _on_push_detection_area_body_entered(body):
    if body is Pushable:
        closest_pushable = body


func _on_push_detection_area_body_exited(body):
    if body is Pushable and closest_pushable == body:
        closest_pushable = null

func entershadow(body):
    closest_shadow=body
    
func exitshadow(body):
    if body==closest_shadow:
        closest_shadow=null
