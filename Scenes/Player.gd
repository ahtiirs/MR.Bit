extends KinematicBody2D

const MOTION_SPEED = 260# Pixels/second.
const maxSpeed = 8
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


	if (moveVector.y == 0):
		motion.y = lerp(0,motion.y, pow(2,  -20 * delta))
	motion.x = clamp(motion.x, -maxSpeed, maxSpeed)
	motion.y = clamp(motion.y, -maxSpeed, maxSpeed)


	#motion = motion.abs() * motion.normalized() 
#	print(motion)
#	motion = move_and_slide(motion, Vector2.UP)
#	if collision:
#	   print("kokkupõrge")
	var collision = move_and_collide(motion )
	if collision:
		$collision.play()
	
	update_animation(moveVector)
	

func update_animation(moveVec):

	if (moveVec.x < 0 && moveVec.y > 0):
		$AnimatedSprite.play("1")
		if !$walk.playing:
			$walk.play()
	if (moveVec.x == 0 && moveVec.y > 0 ):
		$AnimatedSprite.play("2")
		if !$walk.playing:
			$walk.play()
	if (moveVec.x > 0 && moveVec.y  > 0):
		$AnimatedSprite.play("3")
		if !$walk.playing:
			$walk.play()		
	if (moveVec.x > 0 && moveVec.y == 0):
		$AnimatedSprite.play("4")			
		if !$walk.playing:
			$walk.play()
	if (moveVec.x  > 0&& moveVec.y < 0):
		$AnimatedSprite.play("5")
	if (moveVec.x == 0 && moveVec.y < 0):
		$AnimatedSprite.play("6")		
		if !$walk.playing:
			$walk.play()
	if (moveVec.x < 0 && moveVec.y < 0):
		$AnimatedSprite.play("7")
		if !$walk.playing:
			$walk.play()
	if (moveVec.x < 0 && moveVec.y == 0):
		$AnimatedSprite.play("8")		
		if !$walk.playing:
			$walk.play()
	if (moveVec.x == 0 && moveVec.y == 0):
		$AnimatedSprite.play("idle")
		$walk.stop()
		
