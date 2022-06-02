extends WindowDialog


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

	self.visible = false
	var jutt = get_parent().get_parent().get_node("Mother/Emajutt1")
	jutt.play()
	emit_signal("on_dialog")
	pass # Replace with function body.


func _on_No_pressed():
	self.visible = false
	var player =  get_parent().get_parent().get_node("Player")
#	player.set_position(player.get_position() + Vector2(-50, -50))
	
	get_tree().paused = false
	pass # Replace with function body.
