extends Area3D
const ammo_sfx = preload("res://Pickup(1).wav")

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and Global.ammo < 100:
		Global.ammo += 10
		AudioManager.play3D(ammo_sfx, self)
		Global.current_weapon = Global.last_weapon


func _on_audio_stream_player_finished(stream:AudioStream) -> void:
	if (stream == ammo_sfx):
		queue_free()
