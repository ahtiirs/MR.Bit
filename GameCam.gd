extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var players = get_tree().get_nodes_in_group("player")
	if (players.size() > 0):
		var player = players[0]
		global_position = player.global.position
