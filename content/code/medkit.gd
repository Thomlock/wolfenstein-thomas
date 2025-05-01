extends Area3D
const medkit_sfx = preload("res://content/audio/Pickup(1).wav")


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and Global.player_health < 100:
		AudioManager.play3D(medkit_sfx, self)
		Global.player_health = min(Global.player_health + 25, 100)
		print(Global.player_health)
		set_deferred("monitoring", false)


func _on_audio_stream_player_finished(stream:AudioStream) -> void:
	if (stream == medkit_sfx):
		queue_free()
