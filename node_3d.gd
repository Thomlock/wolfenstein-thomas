extends Node3D
@onready var debris = $debris
@onready var fire = $fire
@onready var smoke = $smoke

func explode():
	debris.emitting = true
	fire.emitting = true
	smoke.emitting = true
	AudioManager.play3D(explosion)
	await get_tree().create_timer(2.0).timeout
	queue_free()
