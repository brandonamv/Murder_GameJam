extends CharacterBody3D

@export var speed : float
var direction = Vector2.ZERO
var gravity = 9
var actualInteraction

var camPos={
	ServiceRoom={x=34,z=10},
	Reception={x=28,z=1},
	Lounge={x=44,z=-16},
	RestRoom={x=54,z=-1},
	Corridor1={x=36,z=-39},
	Corridor2={x=17,z=-28}
}

func _physics_process(delta):
	direction = GLOBAL.get_axis()
	
	velocity.x = direction.x * speed
	velocity.z = direction.y * speed
	
	if !is_on_floor():
		velocity.y -= gravity
		
	var player = get_node(".")
	
	if direction != Vector2.ZERO:
		var viewPoint= Vector3.ZERO
		viewPoint.x=direction.x
		viewPoint.z=direction.y
		viewPoint = viewPoint.normalized()
		$Pivot.basis = Basis.looking_at(viewPoint)
		#$Interaction.basis= Basis.looking_at(viewPoint)
		
	if player.position.y < -200 :
		player.position.x = 0
		player.position.y = 2
		player.position.z = 0
	
	var collide=$Interaction.get_overlapping_bodies()
	if Input.is_action_just_pressed("interact"):
		if collide:
			print("interaction is posible",collide[0].name)
			#npc[0].queue_free() #para eliminar el objeto
			collide[0].get_node("Dialog").visible=true
			actualInteraction=collide[0]
			#$"../Cancion".play()
	if !collide and actualInteraction:
		actualInteraction.get_node("Dialog").visible=false
		actualInteraction=null
		#$"../Cancion".stop()
		
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision.get_collider().name in camPos:
			#print(camPos[collision.get_collider().name].x)
			$"../Camera3D".position.x=camPos[collision.get_collider().name].x
			$"../Camera3D".position.z=camPos[collision.get_collider().name].z
	move_and_slide()


