extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 120
const JUMPFORCE = 300
const ACCEL = 10

export (int) var damage := 10

var motion = Vector2.ZERO
var is_attacking = false
var change_direction = false
onready var state_machine = $AnimationTree.get("parameters/playback")

func _process(delta):
	player_movement()

func is_animation_attack_possible(current):
	if current == "run" or current == "jump" or current == "fall":
		return false
	else:
		return true

func player_movement():
	var current = state_machine.get_current_node()
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	motion.x =  clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	if Input.is_action_just_pressed("attack") and is_animation_attack_possible(current):
		state_machine.travel("attack1")
		return
	if Input.is_action_just_pressed("big_attack") and is_animation_attack_possible(current):
		state_machine.travel("attack2 2")
		return
	if Input.is_action_pressed("right"):
		motion.x += ACCEL
		if $Sprite.flip_h != false:
			$Sprite.flip_h = false
			$Area2D/HitCollision.position.x *= -1
	elif Input.is_action_pressed("left"):
		motion.x -= ACCEL
		if $Sprite.flip_h != true:
			$Sprite.flip_h = true
			$Area2D/HitCollision.position.x *= -1
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		state_machine.travel("idle")
	
	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		state_machine.travel("run")
	
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			motion.y = -JUMPFORCE
	
	if !is_on_floor():
		if motion.y < 0:
			state_machine.travel("jump")
		elif motion.y > 0:
			state_machine.travel("fall")
	motion = move_and_slide(motion, UP)

func die():
	queue_free()


func _on_Area2D_body_entered(body: Node) -> void:
	if body.has_method("handle_hit"):
		body.handle_hit(damage)
