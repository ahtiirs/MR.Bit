extends VideoPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var cpu = get_parent().get_node("CPU")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StaapStart_finished():
	cpu.visible = true
	self.visible = false
	
