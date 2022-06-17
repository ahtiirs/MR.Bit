extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var mother = get_parent().get_parent().get_node("Mother")
onready var player = get_parent().get_parent().get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	var angle = player.position.angle_to_point(mother.position)
	$Arrow.set_rotation(angle)
