extends Polygon2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal dialog_start

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func show():

	visible = true

func hide():

	visible = false

func _on_Mother_on_dialog():
	visible = true
	
	emit_signal(("dialog_start"))
