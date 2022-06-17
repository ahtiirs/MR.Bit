extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	if !timer.is_stopped():
#		print(timer.get_time_left())
		self.modulate.a = 1 - abs(timer.get_time_left()-2)/2
	
