extends CharacterBody3D

@export var speed : float
var direction = Vector2.ZERO
var gravity = 9

func _physics_process(delta):
	direction = GLOBAL.get_axis()
	
	velocity.x = direction.x * speed
	velocity.z = direction.y * speed
	
	if !is_on_floor():
		velocity.y -= gravity
	move_and_slide()


