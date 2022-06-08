extends Node

export (NodePath) var Resolution_Choice
onready var Resolution = get_node(Resolution_Choice)

var Res_options =["1920x1080","1280x720"]
onready var Res_selected = $TabContainer/Seaded/ResolutionOptions

var CPU_mode: bool =  false

# Called when the node enters the scene tree for the first time.
func _ready():
	Resolution.add_item("Muuda resolutsiooni")
	Resolution.set_item_disabled(0, true)
	add_resolutions()
	
func add_resolutions():
	for item in Res_options:
		Resolution.add_item(item)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ResolutionOptions_item_selected(index):
	if Res_selected.get_item_text(index) == "1920x1080":
		OS.set_window_size(Vector2(1920,1080))
		OS.set_window_position(Vector2(0,0))
	
	if Res_selected.get_item_text(index) == "1280x720":
		OS.set_window_size(Vector2(1280,720))
		OS.set_window_position(Vector2(0,0))
	
#	if Res_selected.get_item_text(index) == "640x480":
#		OS.set_window_size(Vector2(640,480))
#		OS.set_window_position(Vector2(0,0))
	


func _on_Fullscreen_pressed():
	OS.window_fullscreen = not OS.window_fullscreen


func _on_CPU_Button_pressed():
	CPU_mode = not CPU_mode
	OS.set_low_processor_usage_mode(CPU_mode)


func _on_MasterVolume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),value)


func _on_SFXVolume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("character"),value)


func _on_MasterVolume3_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Jutt"),value)


func _on_MasterVolume4_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"),value)


func _on_Button_pressed():
	self.visible = false
