extends Node2D


func _process(delta: float) -> void:
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
