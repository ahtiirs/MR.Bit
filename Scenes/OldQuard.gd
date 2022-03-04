extends KinematicBody2D

enum {
	IDLE,
	WANDER
}

var velocity = Vector2.ZERO
var state = WANDER

const ACCELERATION = 300
const MAX_SPEED = 250
const TOLERANCE = 140.0

onready var start_position = global_position
onready var target_position = global_position

func update_target_position():
	var target_vector = Vector2(rand_range(-200, 200), rand_range(-200, 200))
	target_position = global_position + target_vector
#	print(target_position)

func is_at_target_position(): 
	# Stop moving when at target +/- tolerance
	return (target_position - global_position).length() < TOLERANCE

func _physics_process(delta):
#	print("staatus: ",state)
	match state:
		IDLE:
			state = WANDER
			# Maybe wait for X seconds with a timer before moving on
			update_target_position()

		WANDER:
			accelerate_to_point(target_position, ACCELERATION * delta)

			if is_at_target_position():
				state = IDLE

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

