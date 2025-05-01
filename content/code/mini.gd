extends Area3D

const mini_sfx = preload("res://All Right!(1).wav")

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		Global.current_weapon = "mini"
		Global.last_weapon = "mini"
		AudioManager.play3D(mini_sfx, self)


func _on_audio_stream_player_finished(stream:AudioStream) -> void:
	if (stream == mini_sfx):
		queue_free()
