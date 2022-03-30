extends KinematicBody2D

const MOTION_SPEED = 240# Pixels/second.
const maxSpeed = 10
const friction = 20 
var acceleration = 2000 # mängija kiirendus ja pidurdus
var motion = Vector2.ZERO 
var collided = false # kui pole seinaga kokkupõrget toimunud siis alväärtus on false
var MaxDistance = 500 # max kaugus millest lähemal vaenlane märkab mängijat
var FOV = 90 # vaenlase vaatenurk
var moveVector = Vector2.ZERO

onready var EnemyToPlayer = global_position
onready var EnemyPosition = get_parent().get_node("OldQuard").get_position()

func _ready():
	pass

func _process(delta):
	EnemyToPlayer = global_position - get_parent().get_node("OldQuard").get_position()

	moveVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	moveVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	motion += moveVector * acceleration * delta 
#	motion = motion.normalized()

	if (moveVector.x == 0):
		motion.x = lerp(0,motion.x, pow(2,  -20 * delta))

	if (moveVector.y == 0):
		motion.y = lerp(0,motion.y, pow(2,  -20 * delta))

	motion.x = clamp(motion.x, -maxSpeed, maxSpeed)
	motion.y = clamp(motion.y, -maxSpeed, maxSpeed)
	
#	if EnemyToPlayer.length() < MaxDistance:
#			print (EnemyToPlayer)
#			print (EnemyToPlayer.dot(motion))
#			print("Mind nähti, jookseni!!!")
	
	var collision = move_and_collide(motion )

	if collision :
		print(collision.collider.name)

			
		if collision.collider.name == "walls":
			if collided == false:
				$collision.play()
				collided = true

	else:
		collided = false
#	moveVector.y = moveVector.y * 1.3
#	moveVector.x = moveVector.x / 1.3
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
		if !$walk.playing:
			$walk.play()

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
		
