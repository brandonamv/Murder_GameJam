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

var interaction={
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
	Planta={
		text={
			no="Es una Planta. A mi padre le gusta que el hotel tenga un poco de vida.",
			si="Mi papá quiere que el hotel parezca un jardín botánico." 
		},
		tomado="no",
	},
	Cubo={
		text={
			no="No tengo que limpiar nada ahora...",
			si="¡Ni en pedo tengo que limpiar nada ahora!" 
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

var dialogs={
	Hotelero={
		text={
			d1="Argus está re raro.",
			d2="Está hace un montón en el depósito.",
			f="Con lo que me pagan, que me haga otra cosa"
		},
		dn="d1"
	},
	Agus={
		text={
			d1="Ey, Sofi... Vi que Marta agarró una llave, ¡qué quilombo!",
			d2="Creo que es porque su gato se mandó una macana y se metió al depósito de limpieza.",
			f="¿Asesinar? Eso me desequilibra"
		},
		dn="d1"
	},
	Mario={
		text={
			d1="¿Que quieres? estoy comiendo.",
			d2="Un gato fastidioso no me ha dejado comer ¿ahora tu tampoco?",
			f="Me han estado jodiendo todo el dia, pero tampoco mataria a alguien por eso."
		},
		dn="d1"
	},
	Sara={
		text={
			d1="Hola, ¿me darias algo de privacidad? por favor",
			d2="Gracias, tuve que esperar mucho que saliera Mario",
			f="No puedo ni dar 3 pasos sin ir al baño, ¿como cometería un asesinato?"
		},
		dn="d1"
	},
	Marta={
		text={
			d1="Oh, eres tu Sofia. ¿En qué te puedo ayudar cariño? ¿Quieres jugar de nuevo con mis bebes?",
			d2="Mi gato ha estado algo travieso hoy",
			f="¿Como lo has descubierto!?",
		},
		dn="d1"
	},
	Jack={
		text={
			d1="¿Qué querés? ¡Estoy re ocupado!",
			d2="¡Primero Marta pidiéndome una botella, ahora me rompes las pelotas vos?!",
			f="Che, ¿Con qué tiempo haría eso?"
		},
		dn="d1"
	},
}
var pistas_encontradas=0
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
			if collide[0].name in interaction:
				var tomado=interaction[collide[0].name].tomado
				$"../Control2/Dialog".text=interaction[collide[0].name].text[tomado]
				interaction[collide[0].name].tomado="si"
			elif collide[0].name in dialogs:
				var dn=dialogs[collide[0].name].dn
				$"../Control2/Dialog".text=collide[0].name+": "+dialogs[collide[0].name].text[dn]
				dialogs[collide[0].name].dn="d2"
			else:
				$"../Control2/Dialog".text="No hay nada aqui"
				
			$"../Control2".visible=true
			actualInteraction=collide
			print("interaction is posible",collide[0].name)
			if collide[0].name=="Estante2":
				$"../Objetos/ServiceRoom/Estante2/Sprite3D".texture= load("res://assets/Tile Assets/Gabinete 2.png")
				pistas_encontradas+=1
			if collide[0].name=="Cubo2":
				$"../Objetos/Lounge/Cubo2/Sprite3D".texture= load("res://assets/Tile Assets/Tacho Vacio.png")
				pistas_encontradas+=1
			if collide[0].name=="Lavamanos":
				pistas_encontradas+=1
			if collide[0].name=="Recepcion":
				$"../Objetos/Reception/Mate".visible=false	
			if collide[0].name=="Mesa3":
				$"../Objetos/Lounge/Arepa".visible=false		
			#npc[0].queue_free() #para eliminar el objeto
			#collide[0].get_node("Dialog").visible=true
			#actualInteraction=collide[0]
			#$"../Cancion".play()
	if Input.is_action_just_pressed("acuse"):
		if collide:
			if collide[0].name in dialogs:
				$"../Control2".visible=true
				actualInteraction=collide
				if pistas_encontradas<3:
					$"../Control2/Dialog".text="No tienes pruebas suficientes para acusar a nadie"
				else:
					$"../Control2/Dialog".text=collide[0].name+": "+dialogs[collide[0].name].text["f"]
					if collide[0].name=="Marta":
						$"../Control2/Dialog".text="Has encontrado al asesino, ¡Felicidades!"
					else:
						$"../Control2/Dialog".text="Te has equivocado, te transportas a donde empezaste."
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




