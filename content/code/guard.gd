extends CharacterBody3D
const SPEED = 5.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")  # Get the gravity from the project settings to be synced with RigidBody nodes.
var dead = false
var is_taking_damage = false
var is_attacking = false 
var attack_range = 10
var guard_health = 100
var invincibility_frame = false
var rand = 0
#var frame_counter = 0
#var current_animation = "default"
const medkit = preload("res://content/code/medkit.tscn")
const ammo = preload("res://content/code/ammo.tscn")
const die_sfx = preload("res://content/audio/Enemy Pain(1).ogg")
const shoot_sfx = preload("res://content/audio/gun.ogg")
@onready var player = Global.player


func _ready():
	add_to_group("enemy")

func _physics_process(delta):
	player = Global.player
	if dead or is_attacking or is_taking_damage:  # Check if the enemy is dead or attacking
		return
	if invincibility_frame == true:
		invincibility_frame = false
	#if current_animation != "default":
	#	$AnimatedSprite3D.play(current_animation)
	#	if frame_counter == 1:
	#		current_animation = "default"
	#		frame_counter = 0
	#	else:
	#		frame_counter = 1
	#else:
	#	$AnimatedSprite3D.play("default")

	if player == null:
		return
		
	var dir = player.global_position - global_position
	dir.y = 0.0
	dir = dir.normalized()
	
	velocity = dir * SPEED
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	

	move_and_slide()
	$AnimatedSprite3D.play("default")
	attack()

func attack():
	#if current_animation != "take_damage":
		var dist_to_player = global_position.distance_to(player.global_position)
		if dist_to_player > attack_range:
			return
			
		else:
			  # Set the attacking flag
			 #delayed by one frame to make the game more friendly
			#$AudioStreamPlayer3D.play()
			#print(self.transform)
			#print($AnimatedSprite3D.transform)
			#$RayCast3D.transform = $AnimatedSprite3D.transform
			#var angle = (player.position-self.position).normalized().angle_to(Vector3(0,0,1))
			#print(angle)
			#$RayCast3D.target_position = player.global_position
			#(to_local(player.position) * get_scale()).
			#$RayCast3D.look_at(player.global_transform.origin, Vector3.UP
			$RayCast3D.target_position=to_local(player.global_position)
			if $RayCast3D.is_colliding() and $RayCast3D.get_collider().has_method("damage"):
				is_attacking = true
				$AnimatedSprite3D.play("shoot")
				AudioManager.play3D(shoot_sfx, self, -20)
				$RayCast3D.get_collider().damage()
				await $AnimatedSprite3D.animation_finished  # Wait for the animation to finish
				is_attacking = false

func take_damage():
	if invincibility_frame == false:
		invincibility_frame = true
		is_taking_damage = true
		guard_health -= 30
		print("guard", guard_health)
		#current_animation = "take_damage"
		#$AnimatedSprite3D.play(current_animation)
		$AnimatedSprite3D.play("damage")
		AudioManager.play3D(die_sfx, self)
		await $AnimatedSprite3D.animation_finished
		is_taking_damage = false
		if guard_health <= 0:
			die()

func die():
	dead = true  # Corrected variable scope
	Global.player_score += 100
	$AnimatedSprite3D.play("die")
	$CollisionShape3D.disabled = true
	AudioManager.play3D(die_sfx, self)
	#while($AnimatedSprite3D.frame != 4):
	#	print("loop")
	#	if $AnimatedSprite3D.animation == "die" and $AnimatedSprite3D.frame == 4:
	#


func _on_animated_sprite_3d_animation_finished() -> void:
	if $AnimatedSprite3D.animation == "die":
		rand = randi()%7
		var loot
		print(rand)
		if rand == 6:
			loot = medkit.instantiate()
		elif rand != 6:
			loot = ammo.instantiate()
		loot.position = self.position
		loot.position.y += 0.5
		print(get_parent())
		get_parent().add_child(loot)
