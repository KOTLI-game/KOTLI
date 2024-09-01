class_name PauseMenu
extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var is_paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause_game"):
		is_paused = !is_paused
		visible = is_paused
	elif is_paused and Input.is_action_just_pressed("menu_exit"):
		is_paused = false
		visible = false
