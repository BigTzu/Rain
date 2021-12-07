extends Area2D


const SPEED = 130
var velocity = Vector2()
var direction = 1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
	

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	if direction != 0:
		$AnimatedSprite.play("Fire")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Fireball_body_entered(body):
	direction = 0
	#$AnimatedSprite.stop()
	$AnimatedSprite.play("Explosion")
	yield(get_tree().create_timer(0.2), "timeout")
	queue_free()
