extends Node2D

var LevelsInfo = [0,7,7,0]
var staapText = {
	"MB":"Sulle on siin monitor ja arvuti korpus  milles on emaplaat. Ülejäänud vajaliku arvuti tööle saamiseks pead leidma vanalt tehase territooriumilt. Kui sa jääd hätta, pöördu ema poole, ta aitab. Ära teda aga liialt tihti tüüta, ema elu pole kerge. Kui liigud ringi, ole ettevaatlik, Bogdan on kuri ja temaga kohtudes jääd iga kord ilma ühest võimalusest arvuti kokku saada. Võimalusi on sul viis.",
	"CPU":"Missioon 1. \n Otsi arvutile protsessor. Leia territooriumilt sümbol mis vihjab mõtlemisele!",
	"RAM":"Missioon 2. \n Otsi arvutile mälu. Leia midagi mis aitab asju meeles pidada ajutiselt!",
	"HDD":"Missioon 3. \n Otsi arvutile kõvaketas. Leia koht milles on kirja pandud palju infot!",
	"PSU":"Missioon 4. \n Otsi arvutile toiteplokk. Leia element mis sisaldab palju energiat!",
	"Keyboard":"Missioon 5. \n Otsi arvutile klaviatuur. Leia element kus on klahvid!",
	"OS":"Missioon 6. \n Mine ema juurde, tema ehk teab kust sa saad OP süsteemi!",
	"GPU":"Missioon 1. \n Otsi arvutile videokaart. Leia seade mis tekitab liikuvat pilti!",
	"Cooler":"Missioon 2. \n Otsi arvutile jahutus. Leia seade mida kasutaksid kuuma ilmaga!",
	"Soundcard":"Missioon 3. \n Otsi arvutile helikaart. Leia seade mis loob heli!",
	"Speaker":"Missioon 4. \n Otsi arvutile kõlarid. Leia seade kust kostub heli!",
	"Mouse":"Missioon 5. \n Otsi arvutile hiir. Leia kedagi või midagi mis on hiire moodi!",
	"Game":"Missioon 6. \n Mine ema juurde, ta teab kust saada üks äge arvutimäng!",
	"Game Over":"Lõpp"
	}


var partText = {
	"MB":"Emaplaat on trükiplaat arvutis, mille sees ja peal on erinevaid elektroonika radu ja seadiseid. Rajad omakorda moodustavad siinid, mida mööda liiguvad andmed erinevate siseseadmete ja ka välisseadmetele.Emaplaadile ühendatakse kõik arvuti siseseadmed ja ka kaudselt kõik välisseadmed",
	"CPU":"Protsessor on mikroskeem, mis täidab käske. Oluline on jälgida emaplaadi ja protsessori omavahelist sobivust.",
	"RAM":"Muutmälu on arvuti keskne mäluseade, kuhu saab andmeid kiirelt kirjutada ja lugeda. Info kustub arvuti väljalülitamisel.",
	"HDD":'Kõvaketas on info pikaajaliseks talletamiseks. Kaasajal kasutatakse SSD-mäluseadmeid, kuid nimetus kõvaketas on endiselt kasutusse jäänud.',
	"PSU":"Arvuti toiteplokk tagab arvuti tööks vajalikele osadele elektrivoolu. Jälgima peab, et võimsus oleks piisav ja sobiks korpusesse.",
	"Keyboard":"Klaviatuur on peamine seade, mille abil inimene saab infot ja käsklusi arvutisse sisestada. Nagu trükimasin vanasti.",
	"OS":"OP süsteem on arvuti hing – see mis kuvab pilti, vahendab käsklusi, muudab arusaamatu bittide rea inimesele arusaadvaks.",
	"GPU":"Graafikakaart on  videokaart, mis on installitud enamikesse arvutusseadmetesse, et kuvada graafilisi andmeid suure selguse, värvide, eraldusvõime ja üldise välimusega. ",
	"Cooler":"Kui arvuti komponendid töötavad, kipuvad nad üle kuumenema, et seda ei juhtuks, peab neid jahutama. Kõige rohkem vajavad jahutust protsessor ja videokaart.",
	"Soundcard":"Et esitada või salvestada heli on vaja vastavat seadet - selleks ongi helikaart. Helikaardil on mikrofoni sisend ja kõlari väljund.",
	"Speaker":"Ilmselt teab igaüks, mis on kõlar – kast, mis teeb häält. Tänapäeval on kõlar sageli juba arvuti korpusesse või monitori ehitatud.",
	"Mouse":"Hiir on pärast klaviatuuri ilmselt järgmine seade, mille abil me arvutit juhime.",
	"Game":"Jehuu, läheb mänguks!",
	"Game Over":"Game Over"
	}


onready var game = get_node("/root/Bit")
onready var mother = get_parent().get_parent().get_node("Mother")
onready var player = get_parent().get_parent().get_node("Player")
onready var staapvideo = get_node("StaapStart")
onready var staapvideoKeyb = get_node("StaapStart_Keyb")
onready var level1end = get_node("Level1_end")
onready var level2end = get_node("Level2_end")
onready var task_window = get_node("StaapText")
onready var intheBag = get_parent().get_node("inTheBag")
onready var component_info = get_node("Partinfo")
onready var progres = .get_parent().get_node("Panel_P/GameLevel")
onready var task_text = task_window.get_node("label")
onready var direction = .get_parent().get_node("MiniMother")
onready var wait = 0
onready var timeout = 15

signal lives
signal levelup



func _ready():
	pass # Replace with function body.current_level

func _process(delta):
	if Input.get_action_strength("skip") && wait == 0:
		wait = timeout
		next_game_status()
		game.bag = game.current_level[game.status]
		_set_progressbar()
	if wait > 0:
		wait  = wait - 1
		
		
func _on_StaapEntrance_body_entered(body):
	if body.name == "Player":
		intheBag.visible = false
		direction.visible = false
#		if game.ok_button[game.status] == 1:
#			self.get_node("StaapText/ok").visible = true
#			self.get_node("Exit").visible = false

			
#>>> 1 <<<< Olemasolevate juppide järgi otsustatakse milist taustavideot mängitakse
		self.get_node("Exit").visible = true  
		get_tree().paused = true
		if game.pc.has("Speaker"):
			staapvideoKeyb.visible = true
			staapvideoKeyb.play()  # ??????????????????? kas meil on speaker video ka ?
		elif game.pc.has("Keyboard"):
			staapvideoKeyb.visible = true
			staapvideoKeyb.play()
		else:
			staapvideo.visible = true
			staapvideo.play()
# -----------------------------------------------------------------------


####################### Kas kott on tühi või on vale jupp siis eli lännu ################################################
func _on_StaapStart_videoFinish():		#Staapi sisenemise video lõppes, tuleb vaadata kas poiss tuli õige jupp kotis

	_bag_compare()
	_back_pic()
	_set_progressbar()
	_right_component()
	_on_Partinfo_renewlist()
	_give_to_mother_something()

########################################################################################################################



func _back_pic():
	#Kott on tühi aga eelnevalt on klaviatuur juba olemas 
	if game.bag == "empty" && game.pc.has("Keyboard"):
		game.bag = "empty_keyb"

	var back_pic = get_node(game.bag) #tuualse pilt kotiga mis vastas kotis olevale muutujale
	back_pic.visible = true
#	task_text.text = staapText[game.current_level[game.status]]	


func _set_progressbar():
	progres.value = int((game.status-LevelsInfo[game.level-1])*100/(LevelsInfo[game.level]-1)) # progress edenemine


func _bag_compare():
	# kui kotis pole mänguetapile vastav jupp ning kott pole märkega "empty" siis üks elu maha
	if game.current_level[game.status] != game.bag && game.bag !="empty": 
		player.lives = player.lives -1
		emit_signal("lives",player.lives)
	task_window.visible = false


func _right_component():
	if game.current_level[game.status] == game.bag:  #Mängija sisenes õige asjaga mäng läheb järgmisele tasemele
		component_info.get_node("label").text = partText[game.bag]	# Toodud komponendi kohta õpetlik info 
		component_info.visible = true
		task_window.visible = false
	else:
		task_text.text = staapText[game.current_level[game.status]]
		task_window.visible = true
	_on_Partinfo_renewlist()

func _give_to_mother_something():
	if game.bag == "Keyboard":
		mother.bag="OS"
	if game.bag == "Mouse":
		mother.bag="Game"
	if game.current_level[game.status] == "Speaker":
		_make_mmouse_collective(true)
	if game.current_level[game.status] == "Mouse":
		_make_mmouse_collective(false)	

func _make_mmouse_collective(pick):
	var mouse = get_parent().get_parent().get_node("Mouse")
	if pick:
		mouse.add_to_group("Collect")
		print("korjatav")
	else:
		mouse.remove_from_group("Collect")

func next_game_status():
	_give_to_mother_something()
	game.pc.append(game.current_level[game.status])
	game.status = game.status +1 
	if game.status > 6:
		game.level = 2
	if game.status > 12:
		game.level = 3
	_on_Partinfo_renewlist()


func _on_ok_pressed():
	if game.ok_button[game.status] == 1:
		next_game_status()
		task_text.text = staapText[game.current_level[game.status]]
	else:	
	
	#	task_text.text = staapText[game.current_level[game.status+1]]
	#	if game.ok_button[game.status] == 0:
	#		self.get_node("StaapText/ok").visible = false
		
		self.get_node("Exit").visible = false
		for _i in self.get_children ():
			_i.visible = false
	#	if game.bag == "OS":
	#		level1end.visible = true
	#		level1end.play()
		get_tree().paused = false
		task_window.visible = false
		direction.visible = true
		game.bag = "empty"

func _partinfo_ok_pressed():
	component_info.visible = false
	if game.bag == "OS":
		level1end.visible = true
		task_window.visible = false
		level1end.play()
	elif game.bag == "Game":
		level2end.visible = true
		task_window.visible = false
		level2end.play()
	else:
		task_text.text = staapText[game.current_level[game.status+1]]
		task_window.visible = true
	game.bag = "empty"
	_back_pic()
	next_game_status()
	emit_signal("renewlist")
	pass # Replace with function body.
	
	





func _on_Partinfo_renewlist():
	if game.level == 1:
		get_tree().set_group("level1_label", "visible", true)
		get_tree().set_group("level2_label", "visible", false)
	if game.level == 2:
		get_tree().set_group("level1_label", "visible", false)
		get_tree().set_group("level2_label", "visible", true)
	
	print("jupid ",game.pc)
	for i in game.pc:
		get_node(i+"_label").modulate.a = 1


func _on_Level1_end_finished():
		component_info.visible = false
		level1end.visible = false
		var levelanime = get_parent().get_node("Level_end/Nextlevelanimation")
		var leveltext = get_parent().get_node("Level_end/Level_text")
		leveltext.text = "TASE 2"
		var levelscreen = get_parent().get_node("Level_end")
		levelscreen.visible = true
		levelanime.play("Nextlevel")
		
func _on_Level2_end_finished():
		component_info.visible = false
		level2end.visible = false
		var end = get_parent().get_node("TheEnd")
		end._start()

#		var levelanime = get_parent().get_node("Level_end/Nextlevelanimation")
#		var leveltext = get_parent().get_node("Level_end/Level_text")
#		leveltext.text = "  LÕPP"
#		var levelscreen = get_parent().get_node("Level_end")
#		levelscreen.visible = true
#		levelanime.play("Nextlevel")


func _on_Nextlevelanimation_animation_finished(anim_name):
		print("levelivahetus_lõpp")
		if anim_name == "Nextlevel":
			var levelscreen = get_parent().get_node("Level_end")
			levelscreen.visible = false
			task_text.text = staapText[game.current_level[game.status]]
			task_window.visible = true
			queue_free()
			get_tree().paused = false
			print(game.level)
			if game.level == 1 || game.level == 2:
				get_tree().change_scene("res://Scenes/Level2.tscn")
			else:
				get_tree().change_scene("res://Scenes/Start_menu.tscn")

			get_tree().paused = false
#			emit_signal("levelup")
#			next_game_status()
#		component_info.visible = true



