extends ColorRect

var foundItem= ""
var newitem = ""

var itemtoComponent = {
	"Brain":"CPU",
	"Piano":"Keyboard",
	"YellowNotes":"RAM",
	"Battery":"PSU",
	"Bookshelf":"HDD",
	"Mouse":"Mouse",
	"Cooler":"Cooler",
	"Projector":"GPU",
	"Taperecorder":"Soundcard",
	"Rupor":"Speaker",
	"Mic":"Mic",
	"OS":"OS",
	"Game":"Game"
	}

var foundText = {
	"MB":"Kas ema mitte ei käskinud sul esmalt staapi minna?",
	"CPU":"Kas see asi aitaks mõelda?",
	"Keyboard":"Kas see on seade millega saaks infot sisestada?",
	"RAM":"Kas sellega saaks midagi meelde jätta?",
	"HDD":"Kas selle abil saaks pikaks ajaks infot talletada?",
	"PSU":"Kas see annaks seadmetele voolu?",
	"Mouse":"Kas see on hiire moodi?",
	"Cooler":"Kas sellega saaks jahutada?",
	"GPU":"Kas see tekitaks seinale liikuvat pilti?",
	"Soundcard":"Kas see toodaks heli?",
	"Speaker":"Kas see tekitab valjut heli?",
	"Mic":"Mic",
	"OS":"Kas see võiks kujutada programmi mis arvuti käima paneb?",
	"Game":"Kas see on programm mida saaks arvutis mängida"
	}
	
var answer = false
onready var game = get_node("/root/Bit")

signal flytoBag

func _ready():
	pass # Replace with function body.

func _process(delta):
	if self.visible:
		if Input.get_action_strength("esc"):
			_on_Leave_pressed()
		if Input.get_action_strength("ok"):
			_on_Take_pressed()
	
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
	if "_" in item:
		newitem = item.split("_")
		foundItem = newitem[1]
	else:
		foundItem = item	
		
	
	print(item)
	
	if game.bag == "empty":
#	if foundText.has(item):
#		print(foundText[item])

#		self.get_node("Label").text = foundText[item]
		print(foundText[game.current_level[game.status]])
		self.get_node("Label").text = foundText[game.current_level[game.status]]
#		for i in foundText:  # for name, age in dictionary.iteritems():  (for Python 2.x)
#			print(i)
#			if i == item:
#				print(i.value)
	else:
		self.get_node("Label").text = foundText[game.current_level[game.status]]
		self.get_node("Label").text += " Kas asendan kotis oleva vidina?"
	
	self.visible = true
	get_tree().paused = true
