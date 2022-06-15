extends WindowDialog

onready var staap = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	if self.visible:
		if Input.get_action_strength("esc"):
			staap._on_ok_pressed()
		if Input.get_action_strength("ok"):
			staap._on_ok_pressed()

func _on_ok_pressed():
	self.visible = false 
	pass # Replace with function body.
