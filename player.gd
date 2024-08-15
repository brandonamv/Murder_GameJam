extends CharacterBody3D

@export var speed : float
@onready var anim = $AnimatedSprite3D 
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
var dialogs={
	Estante2={
		text={
			no="¿Qué rayos? ¿por qué la bolsa con veneno de rata está abierta...?",
			si="Ya no hay nada aqui"
		},
		tomado="no",
	},
	Mesa3={
		text={
			no="Provoca una arepita",
			si="Estaba cartelua"
		},
		tomado="no",
	},
	Recepcion={
		text={
			no="Uh me re pinta un mate ahora",
			si="Pero que rrrico que estaba ese mate"
		},
		tomado="no",
	},
	Cubo2={
		text={
			no="¿Qué es esto? Una botella rota y... ¡¿Eso es sangre?!",
			si="Ya no hay nada aqui"
		},
		tomado="no",
	},
	Lavamanos={
		text={
			no='"Pastillas para dormir", sospechoso...',
			si="Ya no hay nada aqui"
		},
		tomado="no",
	}
	
}
var play=false
func _physics_process(delta):
	
	direction = GLOBAL.get_axis()
	
	velocity.x = direction.x * speed
	velocity.z = direction.y * speed

	if direction.y > 0:
		$AnimatedSprite3D.rotation.y = 84 * 3.1416 / 180
	elif direction.y < 0 : 
		$AnimatedSprite3D.rotation.y = -93 * 3.1416 / 180
		
	if !is_on_floor():
		velocity.y -= gravity
		
	var player = get_node(".")
	
	if direction != Vector2.ZERO:
		var viewPoint= Vector3.ZERO
		viewPoint.x=direction.x
		viewPoint.z=direction.y
		viewPoint = viewPoint.normalized()
		$Pivot.basis = Basis.looking_at(viewPoint)
		anim.play('Walk')
		if !play:
			$"../AudioStreamPlayer".play()
			play=true
	else :
		anim.play('Idle')
		$"../AudioStreamPlayer".stop()
		play=false
		
		#$Interaction.basis= Basis.looking_at(viewPoint)
		
	if player.position.y < -200 :
		player.position.x = 0
		player.position.y = 2
		player.position.z = 0
	
	var collide=$Interaction.get_overlapping_bodies()
	if Input.is_action_just_pressed("interact"):
		if collide:
			if collide[0].name in dialogs:
				$"../Control2".visible=true
				var tomado=dialogs[collide[0].name].tomado
				$"../Control2/Dialog".text=dialogs[collide[0].name].text[tomado]
				dialogs[collide[0].name].tomado="si"
				actualInteraction=collide
			print("interaction is posible",collide[0].name)
			if collide[0].name=="Estante2":
				$"../Objetos/ServiceRoom/Estante2/Sprite3D".texture= load("res://assets/Tile Assets/Gabinete 2.png")
			if collide[0].name=="Cubo2":
				$"../Objetos/Lounge/Cubo2/Sprite3D".texture= load("res://assets/Tile Assets/Tacho Vacio.png")
			if collide[0].name=="Recepcion":
				$"../Objetos/Reception/Mate".visible=false	
			if collide[0].name=="Mesa3":
				$"../Objetos/Lounge/Arepa".visible=false		
			#npc[0].queue_free() #para eliminar el objeto
			#collide[0].get_node("Dialog").visible=true
			#actualInteraction=collide[0]
			#$"../Cancion".play()
	if !collide and actualInteraction:
		$"../Control2".visible=false
		actualInteraction=null
		#$"../Cancion".stop()
		
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision.get_collider().name in camPos:
			#print(camPos[collision.get_collider().name].x)
			$"../Camera3D".position.x=camPos[collision.get_collider().name].x
			$"../Camera3D".position.z=camPos[collision.get_collider().name].z
	move_and_slide()




