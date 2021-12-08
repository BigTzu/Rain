extends KinematicBody2D


var SPEED = 150
var velocity = Vector2(1, 0)
var direction = 1
var originalPosition = Vector2()
onready var player = get_node("/root/Prototype Boss Stage/Player")
onready var fireWorm = get_node("/root/Prototype Boss Stage/FireWormBoss")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("Fire")
	
func flip():
	if ($AnimatedSprite.flip_h):
		$AnimatedSprite.flip_h = false
		$Area2D.position *= -1
	else: 
		$AnimatedSprite.flip_h = true
		$Area2D.position *= -1

func handle_hit(damage):
	print("return to boss")
	SPEED = SPEED * 3
	flip()
	velocity = fireWorm.global_transform.origin - position
	

func _on_Area2D_body_entered(body):
	if body.has_method("handle_hit_player"):
		body.handle_hit_player(10)
		SPEED = 0
	elif body.has_method("handle_hit_boss"):
		body.handle_hit_boss(15)
		SPEED = 0

func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * SPEED)
	if collision_info:
		$AnimatedSprite.play("Explosion")
		yield(get_tree().create_timer(0.2), "timeout")
		queue_free()
	#velocity.x = SPEED * delta * direction
	#translate(velocity)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
