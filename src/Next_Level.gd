extends Area2D

func _on_NextLevel_body_entered(body: Node) -> void:
	if body.get_name() == "Player":
		get_tree().change_scene("res://src/Levels/Level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")
