extends Polygon2D


# Declare member variables here. Examples:
# var a = 2
onready var timeout = 1

signal dialog_start

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func show():

	visible = true

func hide():

	visible = false

func _on_Mother_on_dialog():
	visible = true
	
	emit_signal(("dialog_start"))
