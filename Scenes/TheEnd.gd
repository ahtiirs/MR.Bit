extends Panel

onready var animation  =  get_node("TitleAnimation")	




# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _start():
	self.visible = true
	var backmusic  =  get_parent().get_parent().get_node("Music/AudioStreamPlayer2D")	
	backmusic.stop()
	animation.play("TitleAnim")
	

func _on_TitleAnimation_animation_finished(anim_name):
	queue_free()
	get_tree().change_scene("res://Scenes/Start_menu.tscn")
	get_tree().paused = false
