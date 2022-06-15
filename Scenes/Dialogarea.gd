extends Polygon2D


# Declare member variables here. Examples:
# var a = 2
onready var timeout = 1

signal dialog_start

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
#func _process(delta):
#	if self.visible:
#
#		if Input.get_action_strength("ok") || Input.get_action_strength("ok") && timeout <= 0:
#			timeout=0.7
#			$Dialog._on_Button_pressed()
#		timeout -= delta	
#	pass

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
