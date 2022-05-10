extends Node2D

var staapText = {"MB":"Sulle on siin monitor ja arvuti korpus  milles on emaplaat. Ülejäänud vajaliku arvuti tööle saamiseks pead leidma vanalt tehase territooriumilt. Kui sa jääd hätta, pöördu ema poole, ta aitab. Ära teda aga liialt tihti tüüta, ema elu pole kerge. Kui liigud ringi, ole ettevaatlik, Bogdan on kuri ja temaga kohtudes jääd iga kord ilma ühest võimalusest arvuti kokku saada. Võimalusi on sul viis.    ","CPU":"Prose loomingulinse ülesanne","RAM":"Mälu koominguline tekst","HDD":"Kõvaketta tekst","PSU":"Toiteka tekst","Keyboard":"Klavituuri tekst","OS":"Op süsteemi tekst"}

onready var game = get_parent().get_parent()
onready var staapvideo = get_node("StaapStart")
onready var staapvideoKeyb = get_node("StaapStart_Keyb")
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
	if game.bag != "empty":
		var component = get_node(game.bag)
		print(game.bag)
		component.visible = true
		if game.level1[game.status] == game.bag:
			game.status = game.status +1
			game.pc.append(game.level1[game.status])	
	
	staapmessage.get_node("label").text = staapText[game.level1[game.status]]
	staapmessage.visible = true

	
	
func _on_Exit_pressed():
	self.get_node("Exit").visible = false
	for _i in self.get_children ():
		_i.visible = false
	get_tree().paused = false
	staapmessage.visible = false
	intheBag.visible = true






func _on_ok_pressed():
	staapmessage.get_node("label").text = staapText[game.level1[game.status+1]]
	game.pc.append(game.level1[game.status])
	game.status = game.status +1
	if game.ok_button_l1[game.status] == 0:
		self.get_node("StaapText/ok").visible = 	false
	
