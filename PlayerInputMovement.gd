extends KinematicBody2D

const GRAVITY = 2000.0
const WALK_SPEED = 130
const JUMP_FORCE = -550

var velocity = Vector2()
onready var _animated_sprite = $AnimatedSprite

func _physics_process(delta):
	velocity.y += delta * GRAVITY

	if Input.is_action_pressed("player_move_left"):
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("player_move_right"):
		velocity.x = WALK_SPEED
	else:
		velocity.x = 0

	if Input.is_action_just_pressed("player_jump"):
		velocity.y += JUMP_FORCE

	velocity = move_and_slide(velocity)

	if (velocity.y < 0):
		_animated_sprite.play("Jump")
	elif (velocity.y > 0):
		_animated_sprite.play("Fall")
	elif (velocity.x != 0):
		_animated_sprite.play("Run")
	else:
		_animated_sprite.play("Idle")

	if (velocity.x > 0):
		_animated_sprite.flip_h = false
	elif (velocity.x < 0):
		_animated_sprite.flip_h = true
