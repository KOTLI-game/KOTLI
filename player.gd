class_name Player
extends CharacterBody3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SPRINT_MULTIPLIER = 2
const FRICTION = 8
const controller_look_factor = 11#completely subjective
var mouse_sens = 0.3
var is_sprinting = false

func _physics_process(delta: float) -> void:
	if is_paused():
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		if get_health() == 0:
			respawn()
		if not is_on_floor():
			velocity += get_gravity() * delta
		if Input.is_action_pressed("move_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		var speed = SPEED * min(input_dir.length(), 1)
		if Input.is_action_pressed("move_sprint"):
			is_sprinting = true
		if speed == 0:
			is_sprinting = false
		if is_sprinting:
			speed *= SPRINT_MULTIPLIER
			consume_water(speed * SPRINT_MULTIPLIER * delta)
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
			velocity.z = move_toward(velocity.z, 0, FRICTION * delta)

		consume_hunger(min(input_dir.length_squared(), 1) * speed * delta)
		if get_hunger() == 0:
			consume_health(delta)
		if get_water() == 0:
			consume_health(delta)

		rotate_y(deg_to_rad((Input.get_action_strength("look_left") - Input.get_action_strength("look_right")) * mouse_sens * controller_look_factor))
		move_and_slide()

func respawn() -> void:
	set_health(100)
	set_water(100)
	set_hunger(100)
	velocity = Vector3.ZERO
	position = Vector3(0, 0.5, 0)
	get_parent().find_child("DeathMenu").visible = false

func _input(event):  		
	if event is InputEventMouseMotion:
		if(!is_paused()):
			rotate_y(deg_to_rad(-event.relative.x*mouse_sens))
			
func consume_hunger(ammount: float) -> void:
	get_parent().consume_hunger(ammount)
func consume_water(ammount: float) -> void:
	get_parent().consume_water(ammount)
func consume_health(ammount: float) -> void:
	get_parent().consume_health(ammount)
func get_water() -> float:
	return get_parent().get_water()
func get_hunger() -> float:
	return get_parent().get_hunger()
func get_health() -> float:
	return get_parent().get_health()
func set_water(ammount: float) -> void:
	get_parent().set_water(ammount)
func set_hunger(ammount: float) -> void:
	get_parent().set_hunger(ammount)
func set_health(ammount: float) -> void:
	get_parent().set_health(ammount)
func is_paused() -> bool:
	return get_parent().is_paused()
