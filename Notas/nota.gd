extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	$BlockNotas.visible=true
	$TextureRect.visible=true
	$TextureButton2.visible=true
	$TextureButton.visible=false
	pass # Replace with function body.


func _on_texture_button_2_pressed():
	$BlockNotas.visible=false
	$TextureRect.visible=false
	$TextureButton2.visible=false
	$TextureButton.visible=true
	pass # Replace with function body.
