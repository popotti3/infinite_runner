extends KinematicBody


var run_speed : float
var sidestep_speed : float = 5.0
var velocity:= Vector3()
var gravity : float
var jump_speed : float

var time : float = 0.0
var step_freq : float = 2.0
var step_height : float = 0.2
var step_tillt : float = 8.0

onready var body_Hinge =$bodyHinge
func setup_jump(length : float, height : float, speed : float):
	run_speed = speed
	gravity = 8.0 * height * speed * speed / (length * length)
	jump_speed = 4.0 * height * speed / length
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
 
func _physics_process(delta):
	body_Hinge.translation.y = step_height * (1 + sin(2.0 * PI * step_freq * time))
	body_Hinge.rotation_degrees.z = step_tillt * sin(PI * step_freq * time)
	time += delta
	var sideways: float = 0.0
	if Input.is_action_pressed("move_right"):
		sideways += 1.0
	if Input.is_action_pressed("move_left"):
		sideways -= 1.0
		
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
		
	velocity.y -= gravity * delta
	velocity.x = sideways * sidestep_speed
	velocity.z = -run_speed
		
	velocity = move_and_slide(velocity)
