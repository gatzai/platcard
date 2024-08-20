extends CharacterBody2D

var speed = 200
var gravity = 30
var jump_force = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 500:
			velocity.y = 500
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_force
	
	var hor_dir = Input.get_axis("move_left", "move_right")
	velocity.x = speed * hor_dir
	move_and_slide()
