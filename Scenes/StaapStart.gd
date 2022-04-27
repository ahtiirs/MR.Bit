extends VideoPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var cpu = get_parent().get_node("CPU")
onready var game = get_parent().get_parent().get_parent()



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StaapStart_finished():
	
	self.visible = false
	var component = get_parent().get_node(game.bag)
	print(game.bag)
	component.visible = true
	
