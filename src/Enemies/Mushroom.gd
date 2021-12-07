extends KinematicBody2D

const WALK_SPEED = 100
const GRAVITY = 600

onready var player = get_node("/root/World/Player")

func _physics_process(delta):
	if player:
		var direction = (player.position - position).normalized()
		if not is_on_floor():
			direction.y += GRAVITY
			
		move_and_slide(direction * WALK_SPEED)
		
		$Sprite.set_scale(Vector2(sign(direction.x), 1))
		$AnimationPlayer.play("Run")
		
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			var object = collision.collider
			# if object.is_in_group("player"):
				# object.die()
