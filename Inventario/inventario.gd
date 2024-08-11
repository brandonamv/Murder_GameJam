extends Control

var is_open = false
# Called when the node enters the scene tree for the first time.
func _ready():
	close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Close Open invetario") :
		if is_open :
			close()
		else :
			open()

func open(): 
	self.visible = true
	is_open = true
	
func close():
	self.visible = false
	is_open = false 

func _on_close_button_pressed():
	close()
