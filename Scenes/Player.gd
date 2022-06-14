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
#	var movePerSec = motion.normalized()
#	if EnemyToPlayer.length() < MaxDistance:
#			print (EnemyToPlayer)
#			print (EnemyToPlayer.dot(motion))
#			print("Mind nähti, jookseni!!!")

	
	var collision = move_and_collide(motion)

	if collision :
#		print(collision.collider.name)
#
#		print(to_local(global_position))

		if collision.collider.name == "walls" || collision.collider.name == "Staap" :
			if collided == false:
				$collision.play()
				collided = true
		if collision.collider.name == "Mother":
#			if mother.bag == "OS":
#				OS.visible = true
#				OS.set_collision_mask_bit(0, true)
#				OS.set_collision_mask_bit(1, true)
#
#				OS.set_collision_layer_bit(0, true)
#				OS.set_collision_layer_bit(1, true)
#
#				mother.bag = "empty"
#
#
#			if 	mother.bag == "Game":
#				Game.visible = true
#				print("Näita mängu")
#				Game.set_collision_mask_bit(0, true)
#				Game.set_collision_mask_bit(1, true)
#
#				Game.set_collision_layer_bit(0, true)
#				Game.set_collision_layer_bit(1, true)
#
#				mother.bag = "empty"
#
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

		if collision.collider.get_groups().has("enemy") && collided == false:

			get_tree().paused = true
			$ouch.play()
#			lives = lives -1
#			emit_signal("lives",lives)
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
#	moveVector.y = moveVector.y * 1.3
#	moveVector.x = moveVector.x / 1.3
	update_animation(moveVector)
	if lives <= 0:
		print("stop")
		get_tree().quit() # Mängu lõpp

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
	
	if lives <= 0:
		print("stop")
		get_tree().quit() # Mängu lõpp
