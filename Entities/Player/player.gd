extends CharacterBody3D


const SPEED = 5.0
const ROTATION_SPEED = 0.1
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _process(delta):
	look_at_if_object()
	
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
		
		#look_at(ScreenPointToRay())
		#look_at(Vector3.FORWARD.rotated(Vector3.UP, rotation.y).lerp( direction*-1 , 0.1) + position)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	

func look_at_if_object():
	#print(Vector3(ScreenPointToRay().x * -1 ,position.y, ScreenPointToRay().z * -1))
	print(Vector3(ScreenPointToRay().x * -1 , 0, ScreenPointToRay().z * -1 ))
	print(position)
	look_at(Vector3(ScreenPointToRay().x * -1 , 0, ScreenPointToRay().z * -1 ) + position, Vector3.UP)
	# it seems to look at the point as if the object at the origin no matter where the player is
	#look_at(Vector3(-4 ,0, -4) + position, Vector3.UP)

func ScreenPointToRay():
	var spaceState = get_world_3d().direct_space_state
	
	var mousePos = get_viewport().get_mouse_position()
	var camera = get_tree().root.get_camera_3d()
	var rayOrigin = camera.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 2000
	var rayArray = spaceState.intersect_ray(PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd))
	if rayArray.has("position"):
		return rayArray["position"]
	return Vector3()

