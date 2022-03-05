extends KinematicBody2D

const MOTION_SPEED = 260# Pixels/second.
const maxSpeed = 8
const friction = 20
var acceleration = 2000
var motion = Vector2.ZERO
var screencount = 0
var soundCheck = 0;
var checkPosX = round(int(global_transform.origin[0]))
var checkPosY = round(int(global_transform.origin[1]))

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



	var collision = move_and_collide(motion )
	if (soundCheck != 1):
		if (collision && !$collision.playing && soundCheck != 1 && checkPosX != round(int(global_transform.origin[0]))&& checkPosX != round(int(global_transform.origin[1]))):
			$collision.play()
			checkPosX = round(int(global_transform.origin[0]))
			checkPosY = round(int(global_transform.origin[1]))
			soundCheck += 1
		
	if (soundCheck > 1 ):
		$collision.stop()
	
	if ((abs(int(motion.x)) != 0 || abs(int(motion.y)) != -0) ):
		soundCheck = 0


		
	
		
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
		
