extends RichTextLabel

# Variables
var dialog = [
	"Hei Poiss! Oled siin piisavalt niisama ringi tolgendanud, tee midagi kasulikku ka! Pidevalt räägid, et vaja arvutit,	hankisin sulle emaplaadi mis on juba meie seljataga asuvas staabis arvuti korpuses. Vaata mis sinna veel vaja, siin vedeleb igalpool juppe, vast saad midagi kokku panna!",
	"Jälle sa siin, kas ikka vaatasid staabist järele mida tegema pead?",
	"Aaa sul on protsesorit vaja, no otsi vaata, arvuti mõtleb protsessoriga, mõtle millega sina mõtled!",
	"No mõtle peaga, on sul seal aju millega mõelda, leia endale siis kui pole!"]
var page = 0

# Functions
func _ready():
#	set_process_input(true)
	set_bbcode(dialog[page])
	set_visible_characters(0)

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)
#	print(get_visible_characters())


func _on_Dialogarea_dialog_start():
	print("Alustame dialoogi nr: ",page)
	set_bbcode(dialog[page])
	set_visible_characters(0)
	
	print(get_visible_characters(),get_total_character_count())
	if get_visible_characters() > get_total_character_count():
		if page < dialog.size():
			set_visible_characters(0)
			set_bbcode(dialog[page])
			print(dialog[page])
			page += 1
			

	else:
		set_visible_characters(get_total_character_count())
