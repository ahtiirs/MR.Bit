extends Node2D

var staapText = {"MB":"Sulle on siin monitor ja arvuti korpus  milles on emaplaat. Ülejäänud vajaliku arvuti tööle saamiseks pead leidma vanalt tehase territooriumilt. Kui sa jääd hätta, pöördu ema poole, ta aitab. Ära teda aga liialt tihti tüüta, ema elu pole kerge. Kui liigud ringi, ole ettevaatlik, Bogdan on kuri ja temaga kohtudes jääd iga kord ilma ühest võimalusest arvuti kokku saada. Võimalusi on sul viis.    ","CPU":"Leia protsessor, see on nagu arvuti aju , mis kinnitub emaplaadi külge. See aitab arvutil teostada tehteid ja arvutusi, ning juhib teiste seadmete tööd. Protsessori leiad sümboli juurest, mis vihjab mõtlemisele. Head otsimist!","RAM":"Leia muutmälu, selle poole saab pöörduda  ühteviisi kiirelt nii lugemiseks, kui ka kirjutamiseks.","HDD":"Leia kõvaketas, sinna saab suurel hulgal infot talletada ja seda sealt ka lugeda vastavalt vajadusele.","PSU":"Leia toiteplokk, toiteplokist saab voolu arvuti töötamiseks","Keyboard":"Leia klaviatuur, klaviatuuril on erinevad klahvid, mida saab vajutada ja anda sisendi arvutile.","OS":"Tühi kott ei seisa püsti, samuti ei tööta ka arvuti ilma tarkuseta. Mine küsi emalt veidi tarkust mida arvutisse panna. Seda nimetatakse OP süsteemiks."}


var partText = {"MB":"Emaplaat on trükiplaat arvutis, mille sees ja peal on erinevaid elektroonika radu ja seadiseid. Rajad omakorda moodustavad siinid, mida mööda liiguvad andmed erinevate siseseadmete ja ka välisseadmetele.Emaplaadile ühendatakse kõik arvuti siseseadmed ja ka kaudselt kõik välisseadmed","CPU":"See on arvuti aju ehk keskseade, mis on kinnitatud emaplaadi külge. Kiip sooritab arvuti jaoks vajalikud arvutused. Teostab tehteid ja arvutusi, lisaks teiste seadmete töö juhtimist.","RAM":"on arvuti keskne mäluseade, kuhu saab andmeid kirjutada ja kust saab neid lugeda. Suvapöördus (random access) tähendab seda, et igal mälupesal on oma aadress ning nii lugemiseks kui kirjutamiseks on võimalik pöörduda suvalise aadressi poole. Enamik muutmälusid pole säilmälud, s.t. toite väljalülitamisel mälus olevad andmed hävivad.","HDD":"Arvuti kõvaketas on peamiseks andmekandjaks. Kõvaketas on jäigast materjalist ketas, mis on kaetud magnetiseeruva materjali kihiga, mis omakorda annab võimaluse kõvakettale andmeid salvestada","PSU":"","Keyboard":"","OS":""}


onready var game = get_parent().get_parent()
onready var mother = get_parent().get_node("Mother")
onready var staapvideo = get_node("StaapStart")
onready var staapvideoKeyb = get_node("StaapStart_Keyb")
onready var level1end = get_node("Level1_end")
onready var staapmessage = get_node("StaapText")
onready var intheBag = get_parent().get_node("inTheBag")



func _ready():
	
	pass # Replace with function body.


func _on_StaapEntrance_body_entered(body):
	if body.name == "Player":
		print(game.pc)
		intheBag.visible = false
		if game.ok_button_l1[game.status] == 1:
			self.get_node("StaapText/ok").visible = true
			
		self.get_node("Exit").visible = true
		get_tree().paused = true
		if game.pc.has("Keyboard"):
			staapvideoKeyb.visible = true
			staapvideoKeyb.play()

		else:
			staapvideo.visible = true
			staapvideo.play()


func _on_StaapStart_videoFinish():
	if game.bag == "empty" && game.pc.has("Keyboard"):
		game.bag = "empty_keyb"
	
#	game.bag = "OS" # katse kui on vaja kohe level lõppu
	if game.bag == "OS":
		level1end.visible = true
		level1end.play()
		game.bag == ""
		game.level = 1
	else:
		var component = get_node(game.bag)
		print(game.bag)
		component.visible = true

		
		
	if game.level1[game.status] == game.bag:
#		game.status = game.status +1
		game.pc.append(game.level1[game.status])
		var componentInfo = get_node("Partinfo")
		componentInfo.get_node("label").text = partText[game.bag]
		componentInfo.visible = true
		game.status = game.status +1
		if game.bag == "OS":
			mother.bag="OS"
			
			
		staapmessage.get_node("label").text = staapText[game.level1[game.status]]
		
		get_tree().set_group("level1_label", "visible", true)
		print(game.pc)
		for i in game.pc:
			get_node(i+"_label").modulate.a = 1
		
		staapmessage.visible = true

	
	
func _on_Exit_pressed():
	self.get_node("Exit").visible = false
	for _i in self.get_children ():
		_i.visible = false
	get_tree().paused = false
	staapmessage.visible = false
	game.bag = "empty"
#	intheBag.visible = true
	






func _on_ok_pressed():
	staapmessage.get_node("label").text = staapText[game.level1[game.status+1]]
	game.pc.append(game.level1[game.status])
	game.status = game.status +1
	if game.ok_button_l1[game.status] == 0:
		self.get_node("StaapText/ok").visible = 	false
	


func _on_Level1_end_finished():
	pass # Replace with function body.
