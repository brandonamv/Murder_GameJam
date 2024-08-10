extends Node

var axis: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_axis() -> Vector2: 
	axis.x = int(Input.is_key_label_pressed(KEY_S)) - int(Input.is_key_label_pressed(KEY_W)) 
	axis.y = int(Input.is_key_label_pressed(KEY_A)) - int(Input.is_key_label_pressed(KEY_D))
	return axis.normalized()
