extends KinematicBody2D

const MOTION_SPEED = 260# Pixels/second.
const maxSpeed = 160
const friction = 20
var acceleration = 2000
var motion = Vector2.ZERO
var screencount = 0

func _process(delta):
	var moveVector = Vector2.ZERO
	moveVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	moveVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	
	#motion.x += moveVector.x * acceleration * delta 
	motion += moveVector * acceleration * delta 
	if (moveVector.x == 0):
		motion.x = lerp(0,motion.x, pow(2,  -20 * delta))	

	#motion = motion.normalized() * MOTION_SPEED
	if (moveVector.y == 0):
		motion.y = lerp(0,motion.y, pow(2,  -10 * delta))
	motion.x = clamp(motion.x, -maxSpeed, maxSpeed)
	motion.y = clamp(motion.y, -maxSpeed, maxSpeed)
	motion = move_and_slide(motion, Vector2.UP)
	update_animation(moveVector)
	

func update_animation(moveVec):
	print(moveVec)
	if (moveVec.x == 1 && moveVec.y == 1):
		$AnimatedSprite.play("vpa")
	if (moveVec.x == -1 && moveVec.y == 1):
		$AnimatedSprite.play("pva")
	if (moveVec.x == 1 && moveVec.y == -1):
		$AnimatedSprite.play("pvy")
	if (moveVec.x == -1 && moveVec.y == -1):
		$AnimatedSprite.play("vpy")

