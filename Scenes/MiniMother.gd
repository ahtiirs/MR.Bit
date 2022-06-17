extends StaticBody2D

onready var mother = get_parent().get_parent().get_node("Mother")
onready var player = get_parent().get_parent().get_node("Player")

func _process(delta):
	var angle = player.position.angle_to_point(mother.position)
	$Arrow.set_rotation(angle)



func _on_Bit_minimammi(option):
	self.visible = option
	print("maha või peale")
