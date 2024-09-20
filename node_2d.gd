extends Node2D

var fireInst

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Match.position = get_global_mouse_position() + Vector2(0, 120)
	
	if Input.is_action_just_pressed("Light fire"):
		$Ignite.play()
		var fire = preload("res://Fire.tscn")
		fireInst = fire.instantiate()
		add_child(fireInst)
	
	if Input.is_action_just_released("Light fire"):
		$Extinguish.play(0.03)
		fireInst.delete()
