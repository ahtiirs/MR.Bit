extends TileMap
var status = 0
var level= 1
var bag = "empty"
var pc = ["MB"]
var level1 = ["MB","CPU","RAM","HDD","PSU","Keyboard","OS"]
var ok_button_l1 = [1,0,0,0,0,0,0]
var level2 = ["Mouse","Cooler","GPU","Soundcard","Speaker","Mic"]

enum {
	Brain,
	Notes,
	Books,
	Battery,
	Piano,
	Mother,
	Ruupor,
	Mouse,
	Projecor,
	Recorder,
	Mic,
	Cooler
}

onready var live1 = get_node("GUI/Panel_V/VBoxContainer/Syda1")
onready var live2 = get_node("GUI/Panel_V/VBoxContainer/Syda2")
onready var live3 = get_node("GUI/Panel_V/VBoxContainer/Syda3")
onready var live4 = get_node("GUI/Panel_V/VBoxContainer/Syda4")
onready var live5 = get_node("GUI/Panel_V/VBoxContainer/Syda5")
onready var mist = get_node("GUI/Uduekraan")
onready var timer = get_node("GUI/Uduekraan/Timer")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Player_lives(lives):
	pass # Replace with function body.
	

	print("kotis", bag)

	mist.visible=true
	timer.start()
#	get_tree().paused = true
	
	print(lives)
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



func _on_Timer_timeout():
	mist.visible=false
	get_tree().paused = false
	
	





func _on_StaapStart_Keyb_finished():
	pass # Replace with function body.



