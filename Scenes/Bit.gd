extends Node2D

#var status = 5
var status = 0
var level= 1
var bag = "empty"
var pc = []
#var pc = [	
#	"MB",
#	"CPU",
#	"RAM",
#	"HDD",
#	"PSU",
#	"Keyboard"
#	]
	
var current_level = [
	"MB",
	"CPU",
	"RAM",
	"HDD",
	"PSU",
	"Keyboard",
	"OS",
	"GPU",
	"Cooler",
	"Soundcard",
	"Speaker",
	"Mouse",
	"Game",
	"Game Over"
	]
	
var ok_button = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

signal minimammi

onready var live1 = get_node("walls/GUI/Panel_V/VBoxContainer/Syda1")
onready var live2 = get_node("walls/GUI/Panel_V/VBoxContainer/Syda2")
onready var live3 = get_node("walls/GUI/Panel_V/VBoxContainer/Syda3")
onready var live4 = get_node("walls/GUI/Panel_V/VBoxContainer/Syda4")
onready var live5 = get_node("walls/GUI/Panel_V/VBoxContainer/Syda5")
onready var mist = get_node("walls/GUI/Uduekraan")
onready var timer = get_node("walls/GUI/Uduekraan/Timer")
onready var end = get_node("walls/GUI/TheEnd")



func _on_Player_lives(lives):

	if lives <= 0:
		emit_signal("minimammi",false)
		ShowLives(lives)
		get_tree().paused = true
		end._start()
	else:
		emit_signal("minimammi",false)	
		mist.visible=true
		timer.start()
		get_tree().paused = true
		ShowLives(lives)


func ShowLives(lives):
	if lives >= 1:
		live1.visible=true
	else:
		live1.visible=false
	if lives >= 2:
		live2.visible=true
	else:
		live2.visible=false
	if lives >= 3:
		live3.visible=true
	else:
		live3.visible=false
	if lives >= 4:
		live4.visible=true
	else:
		live4.visible=false
	if lives >= 5:
		live5.visible=true
	else:
		live5.visible=false
	pass


func _on_Timer_timeout():
	mist.visible=false
	get_tree().paused = false
	emit_signal("minimammi",true)

func _on_Staap_levelup():
#
	pass
