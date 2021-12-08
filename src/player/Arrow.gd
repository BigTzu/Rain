extends Area2D

const SPEED = 200
var velocity = Vector2()
var direction = 1

export (int) var damage := 10

func set_arrow_direction(dir):
	direction = dir
	if dir == -1:
		$Sprite.flip_h = true

func _physics_process(delta: float) -> void:
	velocity.x = SPEED * delta * direction
	translate(velocity)
	$AnimationPlayer.play("arrow")


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func _on_Fireball_body_entered(body: Node) -> void:
	if body.has_method("handle_hit"):
		body.handle_hit(damage)
	queue_free()
