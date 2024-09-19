extends Sprite2D

@export var layerNum := 1

var deleteRiseSpeed := 1000.0

var delay := 0.5
var previousFire

var jitterAmount := 1.0
var jitterSpeed = clamp(0.1 * layerNum, 0, jitterAmount)
var jitter := 0.0
var deleting := false

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color.BLUE
	position = get_global_mouse_position()
	var originalShaderMaterial = material
	if originalShaderMaterial is ShaderMaterial:
		var shaderMaterial = originalShaderMaterial.duplicate()
		material = shaderMaterial
		shaderMaterial.set_shader_parameter("layer_num", layerNum + 2)
	else:
		print("OH NO")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !deleting:
		if previousFire:
			var distToTarget = (previousFire.position - position)
			jitter += randf_range(-jitterSpeed, jitterSpeed)
			jitter = clamp(jitter, -jitterAmount, jitterAmount)
			var target = (distToTarget / 5) + position + Vector2(0, -5) + Vector2(jitter, jitter)
			position = target
		else:
			position = get_global_mouse_position()
	else:
		position += Vector2(0, -deleteRiseSpeed * delta)
