extends VideoPlayer


onready var game = get_parent().get_parent().get_parent()

signal videoFinish

func _ready():
	pass # Replace with function body.

func _on_StaapStart_Keyb_finished():
	self.visible = false
	emit_signal("videoFinish")

