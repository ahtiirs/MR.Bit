extends KinematicBody2D

var lives = 5 # mängijal elusid
const MOTION_SPEED = 240# Pixels/second.
const maxSpeed = 10
const friction = 20 
var acceleration = 2000 # mängija kiirendus ja pidurdus
var motion = Vector2.ZERO 
var collided = false # kui pole seinaga kokkupõrget toimunud siis alväärtus on false
var MaxDistance = 500 # max kaugus millest lähemal vaenlane märkab mängijat
var FOV = 90 # vaenlase vaatenurk
var moveVector = Vector2.ZERO


signal lives

enum YesIds {
	Yes,
	No,
	}

onready var EnemyToPlayer = global_position
onready var EnemyPosition = get_parent().get_node("OldQuard").get_position()
#onready var YesPopup = get_parent().get_node("GUI").get_node("YesNo")
onready var YesPopup = get_parent().get_node("GUI/QuestionArea")
onready var OldGuard = get_parent().get_node("OldQuard")
onready var LivesBar = get_node("GUI")
onready var animation = get_parent().get_node("GUI/Animations")





func _ready():
	
#	YesPopup.add_item("Räägin emaga",YesIds.Yes)
#	YesPopup.add_item("Longin edasi",YesIds.No)	
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

		print(to_local(global_position))

		if collision.collider.name == "walls":
			if collided == false:
				$collision.play()
				collided = true
		if collision.collider.name == "Mother":
#			Rect2(global_position.x,global_position.y,YesPopup.rect_size.x,YesPopup.rect_size.y)
#			YesPopup.popup(Rect2(global_position.x,global_position.y,YesPopup.rect_size.x,YesPopup.rect_size.y))
#			YesPopup.popup(Rect2(-500,-500,YesPopup.rect_size.x,YesPopup.rect_size.y))
#			var MotherPosition = get_node("Mother").get_position()
#			YesPopup.popup()
#			YesPopup.rect_position = MotherPosition
						
#			print("alustan dialoogi emaga")
#			YesPopup.visible = true
#			get_tree().paused = true
			pass

		if collision.collider.name == "OldQuard":
			lives = lives -1
			


			self.set_position(Vector2(1543,-1635))
			emit_signal("lives",lives)
			get_tree().paused = true
			
			OldGuard.set_position(Vector2(175,-1920))

			if lives <= 0:
				print("stop")
				get_tree().quit() # Mängu lõpp
				
				
				
		if collision.collider.name == "YellowNotes" && collided != true:
			collided = true
			var game = get_parent()
			var dispBagall = get_parent().get_children()
			var dispBag = get_parent().get_node("GUI/inTheBag/RAM")
			
#			dispBagall.visible = false
			dispBag.visible = true
			animation.play("toTheBag")
			
			game.bag = "Memory"
			pass # Replace with function body.
			
		if collision.collider.name == "Piano" && collided != true:
			collided = true
			var game = get_parent()
			var dispBagall = get_parent().get_children()
			var dispBag = get_parent().get_node("GUI/inTheBag/Piano")

			dispBag.visible = true
			animation.play("toTheBag")
			
			game.bag = "Memory"
			pass # Replace with function body.	

			
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
		
