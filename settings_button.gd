extends Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)
	pass # Replace with function body.

func _button_pressed():
	get_tree().root.get_child(0).get_Settings().visible = true
	button_pressed = false
