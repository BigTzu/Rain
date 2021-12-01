extends Node2D

func _ready() -> void:
	_add_wall(Vector2(0, 430), Vector2(16000, 50))
	
func _add_wall(position: Vector2, size: Vector2) -> void:
	var rect := RectangleShape2D.new()
	rect.set_extents(size)
	
	var collision_shape := CollisionShape2D.new()
	collision_shape.shape = rect
	var collision_object := StaticBody2D.new()
	collision_object.position = position
	collision_object.add_child(collision_shape)
	
	add_child(collision_object)
