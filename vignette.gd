class_name Vignette
extends ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	(material as ShaderMaterial).set_shader_parameter("vignette_color", lerp((material as ShaderMaterial).get_shader_parameter("vignette_color"), Color(0,0,0), delta))

func set_vignette(vignetteColor: Color) -> void:
	(material as ShaderMaterial).set_shader_parameter("vignette_color", vignetteColor)
