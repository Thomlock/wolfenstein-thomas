extends CharacterBody3D

const SPEED = 10
const JUMP_VELOCITY = 4.5
@onready var player = Global.player
@onready var dir = null
@onready var spawned = false

func _physics_process(delta: float) -> void:
	if spawned == true:
		player = Global.player
		dir = player.global_position - global_position
		dir = dir.normalized()
		velocity = dir * SPEED
		
		move_and_slide()

func _on_ready() -> void:
	add_to_group("projectile")


func _on_tree_entered() -> void:
	spawned = true


func _on_child_entered_tree(node: Node) -> void:
	spawned = true
