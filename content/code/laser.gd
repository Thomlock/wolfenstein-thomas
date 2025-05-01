extends CharacterBody3D

const SPEED = 10
const JUMP_VELOCITY = 4.5
@onready var player = Global.player
@onready var dir = null
@onready var spawned = false

func _physics_process(delta: float) -> void:
	move_and_slide()
		

func _on_ready() -> void:
	add_to_group("projectile")
