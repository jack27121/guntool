extends CharacterBody3D

@export var speed = 5
@export var mouse_sensitivity = 0.002

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(_delta):
	var input = Input.get_vector("left","right","forward","backward")
	var movement_dir = transform.basis * Vector3(input.x,0,input.y)
	velocity.x = movement_dir.x * speed
	velocity.z = movement_dir.z * speed
	move_and_slide()

func _input(event):
	#looking around
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))
	
	#quit game
	if event.is_action_pressed("escape"):
		get_tree().quit()
