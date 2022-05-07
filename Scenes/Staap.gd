extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var game = get_parent().get_parent()
onready var staapvideo = get_node("StaapStart")
onready var staapvideoKeyb = get_node("StaapStart_Keyb")




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StaapEntrance_body_entered(body):
	if body.name == "Player":
		get_tree().paused = true
		if game.pc.has("Keyboard"):
			staapvideoKeyb.visible = true
			staapvideoKeyb.play()
		else:
			staapvideo.visible = true
			staapvideo.play()

