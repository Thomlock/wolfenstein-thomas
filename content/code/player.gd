extends CharacterBody3D

var invincibility_frame = false
var knife_range = 3
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const TURN_SPEED = 0.05
const gun_sfx = preload("res://content/audio/gun.ogg")
const mini_sfx = preload("res://content/audio/mini.ogg")
const knife_sfx = preload("res://content/audio/Knife(1).wav")
const machine_sfx = preload("res://content/audio/machine.ogg")
@onready var ui_script = $ui
@onready var ray = $Camera3D/RayCast3D



func _ready():
	add_to_group("player")
	Global.player = self

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# remove the invicibility frame
	if invincibility_frame == true:
		invincibility_frame = false

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	if Input.is_action_pressed("ui_left"):
		self.rotate_y(TURN_SPEED)
	if Input.is_action_pressed("ui_right"):
		self.rotate_y(-TURN_SPEED)
	
	if Input.is_action_pressed("ui_accept"):
		if ui_script.can_shoot:
			shoot()
	
	move_and_slide()
	
func shoot():
	var audio_stream:AudioStream
	match Global.current_weapon:
		"knife":
			audio_stream = knife_sfx
		"gun":
			audio_stream = gun_sfx
		"machine":
			audio_stream = machine_sfx
		"mini":
			audio_stream = mini_sfx
	AudioManager.play3D(audio_stream, self, -30)
		
	if ray.is_colliding():
		var collider = ray.get_collider()
		var distance_to_collider = global_position.distance_to(collider.global_position)
		
		if Global.current_weapon == "knife" and distance_to_collider > knife_range:
			return
		else:
			if collider.has_method("take_damage"):
				collider.take_damage()
		
func damage():
	#if invincibility_frame == false:
	#	invincibility_frame = true
		Global.player_health -= 10
		print(Global.player_health)
		if Global.player_health <= 0:
			if Global.lives <= 1:
				queue_free()
			else:
				Global.lives -= 1
				get_tree().reload_current_scene()
				Global.player_health = 100
				Global.player_score = 0
				Global.current_weapon = "gun"
				Global.last_weapon = "gun"
				Global.ammo = 10
