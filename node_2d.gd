extends Node2D

var fireInst

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Light fire"):
		var fire = preload("res://Fire.tscn")
		fireInst = fire.instantiate()
		add_child(fireInst)
	
	if Input.is_action_just_released("Light fire"):
		fireInst.delete()
