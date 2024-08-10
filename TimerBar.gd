extends ProgressBar

var StartTime = 10
var currentTime
# Called when the node enters the scene tree for the first time.
func _ready():
	currentTime = StartTime
	print("Start")
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	currentTime -= 1
	$".".value = int(currentTime * 100 / StartTime) 
	if $".".value <= 0 : 
		finishTimer()
		$Timer.stop()

func finishTimer() :
	print("Hola")
	
