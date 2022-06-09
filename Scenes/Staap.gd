extends Node2D

var LevelsInfo = [0,7,7,0]
var staapText = {
	"MB":"Sulle on siin monitor ja arvuti korpus  milles on emaplaat. Ülejäänud vajaliku arvuti tööle saamiseks pead leidma vanalt tehase territooriumilt. Kui sa jääd hätta, pöördu ema poole, ta aitab. Ära teda aga liialt tihti tüüta, ema elu pole kerge. Kui liigud ringi, ole ettevaatlik, Bogdan on kuri ja temaga kohtudes jääd iga kord ilma ühest võimalusest arvuti kokku saada. Võimalusi on sul viis.",
	"CPU":"Leia protsessor, see on nagu arvuti aju , mis kinnitub emaplaadi külge. See aitab arvutil teostada tehteid ja arvutusi, ning juhib teiste seadmete tööd. Protsessori leiad sümboli juurest, mis vihjab mõtlemisele. Head otsimist!",
	"RAM":"Leia muutmälu, selle poole saab pöörduda  ühteviisi kiirelt nii lugemiseks, kui ka kirjutamiseks.",
	"HDD":"Leia kõvaketas, sinna saab suurel hulgal infot talletada ja seda sealt ka lugeda vastavalt vajadusele.",
	"PSU":"Leia toiteplokk, toiteplokist saab voolu arvuti töötamiseks",
	"Keyboard":"Leia klaviatuur, klaviatuuril on erinevad klahvid, mida saab vajutada ja anda sisendi arvutile.",
	"OS":"Tühi kott ei seisa püsti, samuti ei tööta ka arvuti ilma tarkuseta. Mine küsi emalt veidi tarkust mida arvutisse panna. Seda nimetatakse OP süsteemiks.",
	"GPU":"Leia videokaart!",
	"Cooler":"Leia jahuti!",
	"Soundcard":"Leia helikaart!",
	"Speaker":"Leia kõlarid!",
	"Mouse":"Leia hiir!",
	"Game":"Leia mäng!",
	"Game Over":"Game Over"
	}


var partText = {
	"MB":"Emaplaat on trükiplaat arvutis, mille sees ja peal on erinevaid elektroonika radu ja seadiseid. Rajad omakorda moodustavad siinid, mida mööda liiguvad andmed erinevate siseseadmete ja ka välisseadmetele.Emaplaadile ühendatakse kõik arvuti siseseadmed ja ka kaudselt kõik välisseadmed",
	"CPU":"Protsessor on arvuti aju ehk keskseade, mis on kinnitatud emaplaadi külge. Kiip sooritab arvuti jaoks vajalikud arvutused. Teostab tehteid ja arvutusi, lisaks teiste seadmete töö juhtimist.",
	"RAM":"Mälu on arvuti keskne mäluseade, kuhu saab andmeid kirjutada ja kust saab neid lugeda. Suvapöördus (random access) tähendab seda, et igal mälupesal on oma aadress ning nii lugemiseks kui kirjutamiseks on võimalik pöörduda suvalise aadressi poole. Enamik muutmälusid pole säilmälud, s.t. toite väljalülitamisel mälus olevad andmed hävivad.",
	"HDD":"Arvuti kõvaketas on peamiseks andmekandjaks. Kõvaketas on jäigast materjalist ketas, mis on kaetud magnetiseeruva materjali kihiga, mis omakorda annab võimaluse kõvakettale andmeid salvestada",
	"PSU":"Toiteplokk on...",
	"Keyboard":"Klaviatuur on...",
	"OS":"OP Süsteem on...",
	"GPU":"Videokaart on...",
	"Cooler":"Jahuti on...",
	"Soundcard":"Helikaart on...",
	"Speaker":"Kõlarid on...",
	"Mouse":"Hiir on...",
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
onready var wait = 0
onready var timeout = 30

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


func next_game_status():
	_give_to_mother_something()
	game.pc.append(game.current_level[game.status])
	game.status = game.status +1 
	if game.status > 6:
		game.level = 2
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
		var levelanime = get_parent().get_node("Level_end/Nextlevelanimation")
		var leveltext = get_parent().get_node("Level_end/Level_text")
		leveltext.text = "  LÕPP"
		var levelscreen = get_parent().get_node("Level_end")
		levelscreen.visible = true
		levelanime.play("Nextlevel")


func _on_Nextlevelanimation_animation_finished(anim_name):
		print("levelivahetus_lõpp")
		if anim_name == "Nextlevel":
			var levelscreen = get_parent().get_node("Level_end")
			levelscreen.visible = false
			task_text.text = staapText[game.current_level[game.status]]
			task_window.visible = true
			queue_free()
			get_tree().paused = false
			get_tree().change_scene("res://Scenes/Start_menu.tscn")

			get_tree().paused = false
#			emit_signal("levelup")
#			next_game_status()
#		component_info.visible = true



