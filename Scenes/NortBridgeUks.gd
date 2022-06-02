extends CollisionShape2D


## Declare member variables here. Examples:
## var a = 2
## var b = "text"
#onready var staapvideo = get_parent().get_parent().get_node("GUI/Staap/StaapStart")
#onready var staap = get_parent().get_parent().get_node("GUI/Staap")
##onready var cpu = get_parent().get_parent().get_node("GUI/StaapStart/CPU")
#signal entering
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
##func _process(delta):
##	pass
#
#func _on_Area2D_body_entered(body):
#	if body.name == "Player":
#		emit_signal("entering")
##		get_tree().paused = true
##		staapvideo.visible = true
##		staapvideo.play()
#
##		get_tree().change_scene("res://Scenes/NorthBrige.tscn")
