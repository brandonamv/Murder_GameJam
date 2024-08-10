extends CharacterBody3D

@export var speed : float
var direction = Vector2.ZERO
var gravity = 9
var actualInteraction

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
	move_and_slide()


