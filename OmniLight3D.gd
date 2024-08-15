extends OmniLight3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var t=0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if t+delta>0.2:
		t=0
		$"../OmniLight3D".light_energy=randf()*5+5
	else:
		t+=delta
	pass
