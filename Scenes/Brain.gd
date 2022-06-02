extends KinematicBody2D

var active
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	active = true # default to true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Area2D_body_entered(body):
	pass


func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
#	print("Keegi somebody astus ajju ", body)
#
#	if body.name == "Player":
#		active = false
#		var game = get_parent()
#		var dispBag = get_parent().get_node("GUI/inTheBag/CPU")
#		dispBag.visible = true
#		game.bag = "Brain"
		pass # Replace with function body.
