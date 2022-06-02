extends KinematicBody2D


enum {
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var state = WANDER
var MaxDistance = 700


const ACCELERATION = 500
const MAX_SPEED = 450
const TOLERANCE = 40.0

onready var start_position = global_position
onready var target_position = global_position

func update_target_position():
	var target_vector = Vector2(rand_range(-400, 400), rand_range(-400, 400))
	target_position = global_position + target_vector
	print ("Uus suvaline target", target_position )
	state = WANDER
	
#	print(target_position)

func is_at_target_position(): 
	# Stop moving when at target +/- tolerance
	return (target_position - global_position).length() < TOLERANCE

func _physics_process(delta):
	print("state->", state)
	
	var	EnemyToPlayer = global_position - get_parent().get_node("Player").get_position()
	if EnemyToPlayer.length() < MaxDistance:
#		print (EnemyToPlayer)
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(global_position, get_parent().get_node("Player").get_position())
		if !result.has("collider"):
			print(result, " Näen SIND!!! Nu Pogodi!")
			target_position = get_parent().get_node("Player").get_position()
			state = CHASE 
		else:
			state = WANDER
		
#	print("staatus: ",state)
	match state:
		IDLE:
			# Maybe wait for X seconds with a timer before moving on
			print ("Olen IDLE", target_position )
			update_target_position()

		WANDER:
			accelerate_to_point(target_position, ACCELERATION * delta)
			if is_at_target_position():
				print ("Lähen IDLE", target_position )
				state = IDLE
				
		CHASE:
			print ("Ajan taga", target_position )
			accelerate_to_point(target_position, ACCELERATION * delta)


	velocity = move_and_slide(velocity)
	update_animation(velocity)

func accelerate_to_point(point, acceleration_scalar):
	var direction = (point - global_position).normalized()
	var acceleration_vector = direction * acceleration_scalar
	accelerate(acceleration_vector)

func accelerate(acceleration_vector):
	velocity += acceleration_vector
	velocity = velocity.clamped(MAX_SPEED)
	
func update_animation(moveVec):
	print ("valvur ",moveVec)
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

