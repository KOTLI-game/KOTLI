class_name Main
extends Node

func is_paused() -> bool:
	return get_PauseMenu().visible or get_DeathMenu().visible or get_MainMenu().visible or get_Settings().visible

func get_PauseMenu() -> PanelContainer:
	return find_child("PauseMenu")
func get_DeathMenu() -> PanelContainer:
	return find_child("DeathMenu")
func get_MainMenu() -> CanvasLayer:
	return find_child("MainMenu")
func get_Settings() -> CanvasLayer:
	return find_child("Settings")
func get_Player() -> Player:
	return find_child("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_paused():
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	if Input.is_action_just_pressed("menu_exit") and get_Settings().visible:
		get_Settings().visible = false
		get_Player().mouse_sens = get_Settings().find_child("SensitivitySlider").value / 100
		if get_Settings().find_child("FullscreenToggle").button_pressed:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		return

	if Input.is_action_just_pressed("pause_game"):
		if !is_paused():
			get_PauseMenu().visible = true
		elif get_PauseMenu().visible:
			get_PauseMenu().visible = false
	elif is_paused() and Input.is_action_just_pressed("menu_exit"):
		if get_PauseMenu().visible:
			get_PauseMenu().visible = false
	if is_paused() and Input.is_action_just_pressed("menu_exit"):
		if get_DeathMenu().visible:
			get_DeathMenu().visible = false

func consume_hunger(ammount: float) -> void:
	(find_child("Inventory").get_child(1).get_child(1) as ProgressBar).value -= ammount
func consume_water(ammount: float) -> void:
	(find_child("Inventory").get_child(1).get_child(2) as ProgressBar).value -= ammount
func consume_health(ammount: float) -> void:
	(find_child("Inventory").get_child(1).get_child(0) as ProgressBar).value -= ammount
	find_child("Vignette").set_vignette(Color.RED)
	if get_health() == 0:
		find_child("DeathMenu").visible = true
func get_water() -> float:
	return (find_child("Inventory").get_child(1).get_child(2) as ProgressBar).value
func get_hunger() -> float:
	return (find_child("Inventory").get_child(1).get_child(1) as ProgressBar).value
func get_health() -> float:
	return (find_child("Inventory").get_child(1).get_child(0) as ProgressBar).value
func set_water(ammount: float) -> void:
	(find_child("Inventory").get_child(1).get_child(2) as ProgressBar).value = ammount
func set_hunger(ammount: float) -> void:
	(find_child("Inventory").get_child(1).get_child(1) as ProgressBar).value = ammount
func set_health(ammount: float) -> void:
	(find_child("Inventory").get_child(1).get_child(0) as ProgressBar).value = ammount
