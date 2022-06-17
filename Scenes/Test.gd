extends Label

onready var game = get_node("/root/Bit")
onready var mother = get_parent().get_parent().get_parent().get_node("Mother")
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#func _process(delta):
#	self.visible = false
#	self.text = "Game step: "+ str(game.status) + "    Game Level: "+ str(game.level)+ " \n"
#	self.text += "Game step goal: "+ str(game.current_level[game.status]) + "\n"
#	self.text += "Pc has: "+ str(game.pc) + "\n"
#	self.text += "In the bag is: "+ str(game.bag) + "\n"
#	self.text += "In the Mother bag is: "+ str(mother.bag) + "\n"
