extends CollisionShape2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var staap = get_parent().get_parent().get_node("GUI/Staap/StaapStart")
#onready var cpu = get_parent().get_parent().get_node("GUI/StaapStart/CPU")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().paused = true
		staap.visible = true
		staap.play()

#		get_tree().change_scene("res://Scenes/NorthBrige.tscn")
