extends KinematicBody2D

const MOTION_SPEED = 260# Pixels/second.
const maxSpeed = 8
const friction = 20 
var acceleration = 2000 # mängija kiirendus ja pidurdus
var motion = Vector2.ZERO 
var collided = false # kui pole seinaga kokkupõrget toimunud siis alväärtus on false
var MaxDistance = 500 # max kaugus millest lähemal vaenlane märkab mängijat
var  FOV = 90 # vaenlase vaatenurk
var moveVector = Vector2.ZERO
var newVector = 0


	
onready var EnemyToPlayer = global_position

onready var EnemyPosition = get_parent().get_node("Player").get_position()
var timer = 0
var tryTime = 0

enum {
	IDLE,
	WANDER,
	CHASE
}



func _ready():
	pass

func update_target_position():
	if timer <= 0 || collided == true && tryTime <= 0:
		timer = (randi() % 8) 
		newVector = randi() % 8
		moveVector = Vector2((randi() % 100) - 100, (randi() % 100) - 100)
	
#		checkForCollision(moveVector*250)
		while checkForCollision(moveVector*250):
			moveVector = Vector2((randi() % 4) - 2, (randi() % 4) - 2)
			print("vaatevektor ",moveVector*500)
		collided = false


func checkForCollision(position):
	get_node("RayCast2D").position = Vector2(0,0)
	get_node("RayCast2D").cast_to = position# sets the length of the ray to 0
	get_node("RayCast2D").force_raycast_update()
	print("Raycast...",$RayCast2D.is_colliding())
	print("Raycast...", $RayCast2D.get_collider ())
	return $RayCast2D.is_colliding()
	

func _process(delta):
	if timer > 0:
		timer -= delta
	if tryTime > 0:
		tryTime -= delta
		
		
	
	EnemyToPlayer = global_position - EnemyPosition

	motion += moveVector * acceleration * delta 

	if (moveVector.x == 0):
		motion.x = lerp(0,motion.x, pow(2,  -20 * delta))
	if (moveVector.y == 0):
		motion.y = lerp(0,motion.y, pow(2,  -20 * delta))
	motion.x = clamp(motion.x, -maxSpeed, maxSpeed)
	motion.y = clamp(motion.y, -maxSpeed, maxSpeed)


	var collision = move_and_collide(motion)


#	print(collision)
#	print(collided)
	
	
	if collision :
#		if collision.Object != null :
#			if collided == false:
#			print("vastu seina")
			update_target_position()
			collided = true
			tryTime=0.0
#	else:
#		collided = false
				
	
	update_target_position()		
	update_animation(moveVector)

	

	


func update_animation(moveVec):

#	print ("valvur ",moveVec)
	if (moveVec.x < 0 && moveVec.y > 0):
		$AnimatedSprite.play("1")
	if (moveVec.x == 0 && moveVec.y > 0 ):
		$AnimatedSprite.play("2")
	if (moveVec.x > 0 && moveVec.y  > 0):
		$AnimatedSprite.play("3")		
	if (moveVec.x > 0 && moveVec.y == 0):
		$AnimatedSprite.play("4")			
	if (moveVec.x  > 0&& moveVec.y < 0):
		$AnimatedSprite.play("5")
	if (moveVec.x == 0 && moveVec.y < 0):
		$AnimatedSprite.play("6")		
	if (moveVec.x < 0 && moveVec.y < 0):
		$AnimatedSprite.play("7")
	if (moveVec.x < 0 && moveVec.y == 0):
		$AnimatedSprite.play("8")		
	if (moveVec.x == 0 && moveVec.y == 0):
		$AnimatedSprite.play("idle")
		
