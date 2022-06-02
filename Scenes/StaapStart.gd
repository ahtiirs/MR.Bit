extends VideoPlayer


onready var game = get_parent().get_parent().get_parent()
onready var staapText = get_parent().get_node("StaapText")

signal videoFinish

func _ready():
	pass # Replace with function body.


func _on_StaapStart_finished():
	
	self.visible = false
	emit_signal("videoFinish")

