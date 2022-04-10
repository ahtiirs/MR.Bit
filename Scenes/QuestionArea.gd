extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal on_dialog

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Yes_pressed():
	emit_signal("on_dialog")
	self.visible = false
	pass # Replace with function body.


func _on_No_pressed():
	self.visible = false
	get_tree().paused = false
	pass # Replace with function body.
