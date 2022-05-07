extends Panel

onready var animation = get_parent().get_node("Animations")

func _ready():
	pass # Replace with function body.


func _on_takeIt_flytoBag(item):
#	var dispBagall = get_parent().get_node("GUI/inTheBag")
	for _i in self.get_children ():
		_i.visible = false

	self.get_node(item).visible = true
#	var intheBag = self.get_node("CPU")
#	inthebag.visible = true
	animation.play("toTheBag")
	
