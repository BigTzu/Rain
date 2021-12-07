extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const GRAVITY = 10
const SPEED = 20
const FLOOR = Vector2(0, -1)

var direction = 1

var velocity = Vector2()
var start_time = 0
var time_now = 0
const FIREBALL = preload("res://Fireball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	start_time = OS.get_unix_time()

func _on_Area2D_area_entered(body):
	if body.is_in_group("Player"):
		direction = direction * -1
		$Area2D.position.x *= -1
		$Position2D.position.x *= -1

func _physics_process(delta):
	time_now = OS.get_unix_time()
	var time_elapsed = time_now - start_time
	if time_elapsed > 1.5:
		start_time = OS.get_unix_time()
		var fireball = FIREBALL.instance()
		get_parent().add_child(fireball)
		fireball.set_fireball_direction(direction)
		fireball.position = $Position2D.global_position
	velocity.x = SPEED * direction
	if direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true 
	$AnimatedSprite.play("walk")
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR)
	
	if is_on_wall():
		direction = direction * -1
		$Area2D.position.x *= -1
		$Position2D.position.x *= -1
