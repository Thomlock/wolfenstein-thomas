extends Area3D

const machine_sfx = preload("res://Pickup(1).wav")

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		Global.current_weapon = "machine"
		Global.last_weapon = "machine"
		AudioManager.play3D(machine_sfx, self)

func _on_audio_stream_player_finished(stream:AudioStream) -> void:
	if (stream == machine_sfx):
		queue_free()
