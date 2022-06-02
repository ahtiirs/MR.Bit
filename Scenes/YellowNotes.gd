extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_YellowNotes_input_event(viewport, event, shape_idx):
	print(event)
	if event.name == "Player":
		var game = get_parent()
		var dispBag = get_parent().get_node("GUI/inTheBag/RAM")
		dispBag.visible = true
		game.bag = "RAM"
