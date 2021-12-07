extends KinematicBody2D

const GRAVITY = 10
const SPEED = 30

var velocity = Vector2()

var is_moving_right = false

export (int) var health := 30
export (int) var damage := 10

var direction = 1

var is_dead = false
onready var player = get_node("/root/World/Player")

func dead():
	velocity = Vector2(0, 0)
	$AnimationPlayer.play("Death")
	if is_dead == true:
		queue_free()
	is_dead = true
	
func handle_hit(damage):
	health -= damage
	$AnimationPlayer.play("Hit")
	print("enemy was hit, current health: " + str(health))
	if health <= 0:
		dead()

func _process(_delta):
	move_character()
	detect_turn_around()

func move_character():
	if $AnimationPlayer.current_animation == "Attack" or $AnimationPlayer.current_animation == "Hit" or is_dead == true:
		return
	$AnimationPlayer.play("Run")
	velocity.x = -SPEED if is_moving_right else SPEED
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, Vector2.UP)

func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor() or is_on_wall():
		is_moving_right = !is_moving_right
		scale.x = -scale.x
	
func hit():
	$AttackDetector.monitoring = true

func end_of_hit():
	$AttackDetector.monitoring = false

func start_walk():
	$AnimationPlayer.play("Run")
	
func _on_PlayerDetector_body_entered(body: Node) -> void:
	if body.get_name() == "Player" and is_dead == false:
		$AnimationPlayer.play("Attack")
	
func _on_AtackDetector_body_entered(body: Node) -> void:
	if body.has_method("handle_hit_player"):
		body.handle_hit_player(damage)
##   FOLLOW PLAYER AI

# const WALK_SPEED = 100
# const GRAVITY = 600
# onready var player = get_node("/root/World/Player")

#func _physics_process(delta):
	#if player:
	#	var direction = (player.position - position).normalized()
	#	if not is_on_floor():
	#		direction.y += GRAVITY
	#		
	#	move_and_slide(direction * WALK_SPEED)
		
	#	$Sprite.set_scale(Vector2(sign(direction.x), 1))
	#	$AnimationPlayer.play("Run")
	#	
	#	for i in get_slide_count():
	#		var collision = get_slide_collision(i)
	#		var object = collision.collider
			# if object.is_in_group("player"):
				# object.die()
