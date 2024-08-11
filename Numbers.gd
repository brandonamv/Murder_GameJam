extends Sprite2D

var textures = [load("res://Reloj/Number 0.svg"),
load("res://Reloj/Number 1.svg"),
load("res://Reloj/Number 2.svg"),
load("res://Reloj/Number 3.svg"),
load("res://Reloj/Number 4.svg"),
load("res://Reloj/Number 5.svg"),
load("res://Reloj/Number 6.svg"),
load("res://Reloj/Number 7.svg"),
load("res://Reloj/Number 8.svg"),
load("res://Reloj/Number 9.svg")
]

var currentTeture = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func ChangeNumber (number) :
	$'.'.texture = textures[number]
