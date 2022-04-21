extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var live1 = get_node("Syda1")
onready var live2 = get_node("Syda2")
onready var live3 = get_node("Syda3")
onready var live4 = get_node("Syda4")
onready var live5 = get_node("Syda5")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func changeLives(lives):
	print(lives)
	if lives == 1:
		live1.visible=true
	if lives == 2:
		live2.visible=true
	if lives == 3:
		live3.visible=true
	if lives == 4:
		live4.visible=true
	if lives == 5:
		live5.visible=true

