extends RichTextLabel

#onready var game = get_parent().get_parent().get_parent()
onready var game = get_node("/root/Bit")

onready var mother = get_parent().get_parent().get_parent().get_node("Mother")
onready var OS = get_parent().get_parent().get_parent().get_node("OS")
onready var Game = get_parent().get_parent().get_parent().get_node("Game")



# Variables
var dialog = {
	"MB":"Hei poja, tahtsid endale ehitada arvuti? Emaplaat on ainus komponent, mille mina sulle alguses annan. Sa leiad selle staabist.  Sealt saad ka oma järgmise missiooni. Jälgi juhiseid täpselt, vale asi kotis staapi sisenedes kaotad elu. Elusid on sul kokku viis. Ringi liikudes ole väga ettevaatlik! Siin valvab kuri Bogdan. Kui temaga kohtud kaotad alati ühe elu. Hätta jäädes tule räägi minuga, ehk oskan nõu anda. Edu sulle poja! ",
	"CPU":"Äkki on aju see mida sa vajad!",
	"RAM":"Leia midagi millele saab kiirelt asju üles märkida, et meelest ei läheks! ",
	"HDD":"Vanasti oli kogu tarkus pikaks ajaks talletatud raamatutesse, ehk leiad raamatuid!",
	"PSU":"Telefonid saavad energiat akudest, äkki saab arvuti ka!",
	"Keyboard":"Leia midagi millel saab klahidel lõbusalt klõbistada!",
	"OS":"Uskumatu lugu, aga kohtasin siin ennist üht pingviini, Linux kasutab pingviini oma logona, ehk saad temalt programmi!",
	"GPU":"Leia midagi millega kinos linale filmi lastakse!",
	"Soundcard":"Vanaisal oli see asi mida sa otsid, ta kuula oma lemmiklugusid sellega!",
	"Cooler":"Leia midagi mis paneks õhu liikuma!",
	"Speaker":"Selle asja abil saab end valjult kuuldavaks teha",
	"Mouse":"Püüa see rott kinni kes siin sebib, ma koguaeg ehmatan kui teda näen!",
	"Game":"Nägin siin mingit kirevat karpi kusagil vedelemas, tundus mängu moodi olevat, mine otsi üles!"
	}


var page = 0
var paragraph = true
var kontroll = 0

onready var timer = $Timer
onready var DialogArea = get_parent()

# Functions
func _ready():

	set_bbcode(dialog[game.current_level[game.status]])
	set_visible_characters(0)

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)
	if get_visible_characters() > get_total_character_count():
		paragraph = true
		set_visible_characters(get_total_character_count())

func _on_QuestionArea_on_dialog():
	var jutt = get_parent().get_parent().get_parent().get_node("Mother/"+game.current_level[game.status])
	if jutt != null:
		jutt.play()

	DialogArea.visible = true
	if page < dialog.size() && paragraph == true:
		set_bbcode(dialog[game.current_level[game.status]])
		set_visible_characters(0)
		page += 1
		paragraph = false
	else:
		set_visible_characters(get_total_character_count())

	print("kontroll ",page)
	kontroll+=1
	if game.current_level[game.status] == "OS":
		game.bag = "OS"

func _on_Button_pressed():
	var jutt = get_parent().get_parent().get_parent().get_node("Mother/"+game.current_level[game.status])
	if jutt != null:
		jutt.stop()
	_mother_helps()
	DialogArea.visible = false
	get_tree().paused = false
	pass # Replace with function body.
	
	
func _mother_helps():
	if mother.bag == "OS":
		OS.visible = true
		OS.set_collision_mask_bit(0, true)
		OS.set_collision_mask_bit(1, true)

		OS.set_collision_layer_bit(0, true)
		OS.set_collision_layer_bit(1, true)

		mother.bag = "empty"


	if 	mother.bag == "Game":
		Game.visible = true
		print("Näita mängu")
		Game.set_collision_mask_bit(0, true)
		Game.set_collision_mask_bit(1, true)

		Game.set_collision_layer_bit(0, true)
		Game.set_collision_layer_bit(1, true)

		mother.bag = "empty"
