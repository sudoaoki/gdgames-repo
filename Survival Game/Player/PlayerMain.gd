extends KinematicBody


# Variables
var mouse_sensitivity = 0.05
var h_acceleration = 6
var direction = Vector3()
var gravity_vec = Vector3()
var h_velocity = Vector3()
var player_movement = Vector3()
export var player_gravity = 20
export var player_jumpheight = 10
export var player_speed = 10
onready var head = $Head

# Player Skills
export var PLAYER_SKILLS = "------------------"
export var woodcutting = 1 # Woodcutting skill level
export var woodcutting_xp = 0
export var woodcutting_xpmax = 500 # XP required to level up woodcutting
export var mining = 1 # Mining skill level
export var mining_xp = 0
export var mining_xpmax = 500 # XP required to level up mining

# Player Resources
export var PLAYER_RESOURCES = "------------------"
export var wood_logs = 10000
export var stone_bricks = 10000





func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# whenever there is input
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))


# every physics frame
func _physics_process(delta):
	direction = Vector3()


	if not is_on_floor():
		gravity_vec += Vector3.DOWN * player_gravity * delta
	else:
		gravity_vec = -get_floor_normal() * player_gravity
	
	if Input.is_action_just_pressed("pjump") and is_on_floor():
		gravity_vec = Vector3.UP * player_jumpheight
		print(gravity_vec)


	# movement controls
	if Input.is_action_pressed("pforward"):
		direction -= transform.basis.z
	elif Input.is_action_pressed("pbackward"):
		direction += transform.basis.z
	
	if Input.is_action_pressed("pleft"):
		direction -= transform.basis.x
	elif Input.is_action_pressed("pright"):
		direction += transform.basis.x
		
	
	direction = direction.normalized() # makes it so you don't move faster when going diagonally
	h_velocity = h_velocity.linear_interpolate(direction * player_speed, h_acceleration * delta)
	player_movement.z = h_velocity.z + gravity_vec.z
	player_movement.x = h_velocity.x + gravity_vec.x
	player_movement.y = gravity_vec.y
	move_and_slide(player_movement, Vector3.UP)
