extends Area2D

func _on_NextLevel_body_entered(body: Node) -> void:
	if body.get_name() == "Player":
		get_tree().change_scene("res://src/Levels/Prototype Boss Stage.tscn")
