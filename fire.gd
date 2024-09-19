extends Node2D

@export var numOfFire := 10
@export var deleteSpeed := 50.0

var deletingAt := 0.0

var previousFire
var fireList: Array
var deleting := false
var isDone := false

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in numOfFire:
		var fire = preload("res://fire_piece.tscn")
		var fireInst = fire.instantiate()
		if previousFire:
			fireInst.previousFire = previousFire
		fireInst.layerNum = i - 1
		add_child(fireInst)
		previousFire = fireInst
		fireList.append(previousFire)

func delete():
	deleting = true
	for fire in fireList:
		fire.deleting = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isDone:
		if !$Extinguish.playing:
			$Extinguish.play(0.03)
		$Burning.stop()
	
	if deleting && fireList.size() > 0:
		deletingAt += delta * deleteSpeed
		for i in deletingAt:
			if i < fireList.size() && is_instance_valid(fireList[i]):
				fireList[i].queue_free()
				if i == fireList.size() - 1:
					isDone = true

func _on_extinguish_finished():
	queue_free()
