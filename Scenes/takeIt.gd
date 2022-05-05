extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var foundPart = ""
var foundText = {"Brain":"Oi, leidsin aju ","Piano":"Pianoleidmise tekst"}
var answer = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Take_pressed():
	print(foundPart,answer)
	self.answer = true
	print(foundPart,answer)
	self.visible = false
	get_tree().paused = false
	pass # Replace with function body.


func _on_Leave_pressed():
	print(foundPart,answer)
	self.answer = false
	print(foundPart,answer)
	self.visible = false
	get_tree().paused = false
	pass # Replace with function body.
