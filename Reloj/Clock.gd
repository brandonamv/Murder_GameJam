extends Control

var StartTime = 120
var currentTime

# Called when the node enters the scene tree for the first time.
func _ready():
	currentTime = StartTime
	$Clock/Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	currentTime -= 1
	var minutos = round(currentTime / 60)
	var segundos = currentTime - 60 * minutos
	var seg1 = segundos % 10
	var seg2 = segundos / 10
	var minutos2 = minutos / 10
	var minutos1 = minutos % 10
	$Seg1/container/Number.ChangeNumber(seg1)
	$Seg2/container/Number.ChangeNumber(seg2)
	$Min1/container/Number.ChangeNumber(minutos1)
	$Min2/container/Number.ChangeNumber(minutos2)
	if currentTime <= 0 : 
		finishTimer()
		$Clock/Timer.stop()

func finishTimer() :
	print("Hola")
	
	
