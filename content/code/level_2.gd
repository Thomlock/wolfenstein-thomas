extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_door_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		Global.current_level = 3
		get_tree().change_scene_to_file("res://content/code/level_3.tscn")
