extends KinematicBody2D

var lives = 5 # mängijal elusid
#const MOTION_SPEED = 180# Pixels/second.
const maxSpeed = 8
const friction = 20 
var acceleration = 2000 # mängija kiirendus ja pidurdus
var motion = Vector2.ZERO 
var collided = false # kui pole seinaga kokkupõrget toimunud siis alväärtus on false
var MaxDistance = 500 # max kaugus millest lähemal vaenlane märkab mängijat
var FOV = 90 # vaenlase vaatenurk
var moveVector = Vector2.ZERO


signal lives
signal foundItem


enum YesIds {
	Yes,
	No,
	}

onready var EnemyToPlayer = global_position
onready var EnemyPosition = get_parent().get_node("OldQuard").get_position()
onready var mother = get_parent().get_node("Mother")
onready var game = get_node("/root/Bit")
#onready var YesPopup = get_parent().get_node("GUI").get_node("YesNo")
onready var YesPopup = get_parent().get_node("GUI/QuestionArea")
onready var OldGuard = get_parent().get_node("OldQuard")
onready var LivesBar = get_node("GUI")
onready var animation = get_parent().get_node("GUI/Animations")
onready var take = get_parent().get_node("GUI/takeIt")
onready var takeLabel = get_parent().get_node("GUI/takeIt/Label")
onready var OS = get_parent().get_node("OS")
onready var Game = get_parent().get_node("Game")
onready var end = get_parent().get_node("GUI/TheEnd")


func _process(delta):
	EnemyToPlayer = global_position - get_parent().get_node("OldQuard").get_position()


	moveVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	moveVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	motion += moveVector * acceleration * delta 


	if (moveVector.x == 0):
		motion.x = lerp(0,motion.x, pow(2,  -20 * delta))

	if (moveVector.y == 0):
		motion.y = lerp(0,motion.y, pow(2,  -20 * delta))

	motion.x = clamp(motion.x, -maxSpeed, maxSpeed)
	motion.y = clamp(motion.y, -maxSpeed, maxSpeed)
	
	var collision = move_and_collide(motion)

	if collision :
		if collision.collider.name == "walls" || collision.collider.name == "Staap" :
			if collided == false:
				$collision.play()
				collided = true

		if collision.collider.get_groups().has("enemy") && collided == false:

			get_tree().paused = true
			$ouch.play()
			collided = true


			if lives <= 0:
				print("stop")
				get_tree().quit() # Mängu lõpp


		var collGroups = collision.collider.get_groups()
#		print("collArray",collGroups)
		
		if collision.collider.get_groups().has("Collect") && collided == false:
			collided = true
			var foundItem = ""
#			print("bag: ",game.bag)
#			print("collider name: ",collision.collider.name)
#			print(take.itemtoComponent[collision.collider.name])
			if "_" in collision.collider.name:
				var newitem = collision.collider.name.split("_")
				foundItem = newitem[1]
			else:
				foundItem = collision.collider.name
			if game.bag != take.itemtoComponent[foundItem]:
				emit_signal("foundItem",collision.collider.name)		
				
#	

			
	else:
		collided = false
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

func _on_ouch_finished():
	get_tree().paused = false
	OldGuard.notcatch = true
	lives = lives -1
	emit_signal("lives",lives)
	self.set_position(Vector2(1543,-1635))
	OldGuard.set_position(Vector2(175,-1920))

