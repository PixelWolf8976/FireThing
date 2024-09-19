extends Sprite2D

@export var layerNum := 1

var deleteRiseSpeed := 1000.0

var delay := 0.5
var previousFire

var jitterAmount := 100.0 * (10 - layerNum) * 0.001
var jitterSpeed = clamp(layerNum * 2.0, 0, jitterAmount)
var jitter := 0.0
var deleting := false

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_global_mouse_position()
	scale = Vector2((10 - layerNum) * 0.1, (10 - layerNum) * 0.1)
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
			var target = lerp(position, previousFire.position + Vector2(0, (10 - layerNum) * 0.1 * -25) + Vector2(jitter, 0), delta * 25)
			position = target
		else:
			position = get_global_mouse_position()
	else:
		position += Vector2(0, -deleteRiseSpeed * delta)
