extends HBoxContainer

var StartTime = 120
var currentTime

# Called when the node enters the scene tree for the first time.
func _ready():
	currentTime = StartTime
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	currentTime -= 1
	var minutos = round(currentTime / 60)
	var segundos = currentTime - 60 * minutos
	$Minutos.text = str(minutos)
	$Segundos.text = str(segundos)
	if currentTime <= 0 : 
		finishTimer()
		$Timer.stop()

func finishTimer() :
	print("Hola")
	
	
