extends ColorRect

var foundItem= ""
var itemtoComponent = {"Brain":"CPU","Piano":"Keyboard","YellowNotes":"RAM","Battery":"PSU","Bookshelf":"HDD"}
var foundText = {"Brain":"Oi, leidsin aju ","Piano":"Pianoleidmise tekst"}
var answer = false
onready var game = get_parent().get_parent()

signal flytoBag

func _ready():
	pass # Replace with function body.

func _on_Take_pressed():
	self.answer = true
	emit_signal("flytoBag",itemtoComponent[foundItem])
	game.bag = itemtoComponent[foundItem]
	self.visible = false
	
	get_tree().paused = false
	
	pass # Replace with function body.

func _on_Leave_pressed():
	self.answer = false
	self.visible = false
	get_tree().paused = false
	pass # Replace with function body.

func _on_Player_foundItem(item):
	foundItem = item
	print(item)
	if foundText.has(item):
		print(foundText[item])
		self.get_node("Label").text = foundText[item]
#		for i in foundText:  # for name, age in dictionary.iteritems():  (for Python 2.x)
#			print(i)
#			if i == item:
#				print(i.value)
	else:
		self.get_node("Label").text = "Sellise vidina koha pole mul veel sõnu"
	self.visible = true
	get_tree().paused = true
