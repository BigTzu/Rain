extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const GRAVITY = 10
const SPEED = 20
const FLOOR = Vector2(0, -1)
var start_time = 0
var time_now = 0
var health = 100
const FIREBALL = preload("res://src/Boss/Fireball.tscn")
onready var player = get_node("/root/Prototype Boss Stage/Player")
onready var leftPosition = get_node("/root/Prototype Boss Stage/Left Boss Position")
onready var rightPosition = get_node("/root/Prototype Boss Stage/Right Boss Position")
var direction = 1
var velocity = Vector2()
var delay = 1.5
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.flip_h = true 
	$Node2D.position.x *= -1
	$AnimatedSprite.play("idle")
	start_time = OS.get_unix_time()

#func _on_Area2D_area_entered(body):
#	player = body
#	print("testets")
	#if body.is_in_group("Player"):
	#	direction = direction * -1
	#	$Area2D.position.x *= -1
	#	$Node2D/Position2D.position.x *= -1

func getHealth() :
	return health

func handle_hit_boss(damage):
	print("ies dead")
	health -= damage
	if health <= 0:
		$AnimatedSprite.stop()
		$AnimatedSprite.play("death")
		yield(get_tree().create_timer(1), "timeout")
		get_tree().change_scene("res://src/Levels/Level_ending.tscn")
	elif health <= 75 and health > 55:
		position = leftPosition.position
		$AnimatedSprite.flip_h = false
		$Node2D.position.x *= -1
		for i in 7:
			var fireball = FIREBALL.instance()
			get_parent().get_parent().add_child(fireball)
			fireball.position = $Node2D/Position2D.global_position
			fireball.velocity = player.global_transform.origin - fireball.position
			yield(get_tree().create_timer(0.3), "timeout")
	elif health <= 35 and health > 11 :
		position = rightPosition.position
		$AnimatedSprite.flip_h = true
		$Node2D.position.x *= -1
		for i in 7:
			var fireball = FIREBALL.instance()
			get_parent().get_parent().add_child(fireball)
			fireball.flip()
			fireball.position = $Node2D/Position2D.global_position
			fireball.velocity = player.global_transform.origin - fireball.position
			yield(get_tree().create_timer(0.3), "timeout")
	else:	
		$AnimatedSprite.stop()
		$AnimatedSprite.play("get hit")
		yield(get_tree().create_timer(0.5), "timeout")
		$AnimatedSprite.play("idle")

func _physics_process(delta):
	if (health > 0):
		$Node2D.look_at(player.position)
		time_now = OS.get_unix_time()
		var time_elapsed = time_now - start_time
		if time_elapsed > delay:
			print("firee")
			start_time = OS.get_unix_time()
			var fireball = FIREBALL.instance()
			get_parent().get_parent().add_child(fireball)
			if position != leftPosition.position:
				fireball.flip()
			fireball.position = $Node2D/Position2D.global_position
			fireball.velocity = player.global_transform.origin - fireball.position
		velocity.x = SPEED * direction
		velocity.y += GRAVITY
	#velocity = move_and_slide(velocity, FLOOR)
