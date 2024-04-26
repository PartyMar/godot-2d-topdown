class_name UI extends CanvasLayer
@onready var hp_label = $Control/Panel/HP
@onready var keys_label = $Control/Panel/Keys
@onready var interact_message = $Control/InteractPanel/InteractMessage

#Timer for message
@export var message_shown_current:float = 0
@export var message_shown_max:float = 10

#Keys
@export var keys:int = 0

#HP
@export var hp_current:int = 10
@export var hp_max:int  = 10

func _ready():
	_set_hp_text()
	_set_key_text()

func _process(delta):
	_message_timer(delta)

func _reset():
	await LevelLoader.reset_items()
	
	hp_max = 10
	hp_current = hp_max
	_set_hp_text()
	
	keys = 0
	_set_key_text()
	
	_set_text_message("")


#Message functions
func _set_text_message(message):
	interact_message.text = message
	message_shown_current = 0

func _message_timer(delta):
	message_shown_current+=delta
	if(message_shown_current>=message_shown_max):
		interact_message.text = ""


#Key functions
func _set_key_text():
	keys_label.text = "KEYS: "+str(keys)

func _add_key(value:int):
	var new_value = value+keys
	if(new_value<0): return false
	keys = new_value
	_set_key_text()
	return true


#HP functions
func _set_hp_text():
	hp_label.text = "HP "+str(hp_current)+"/"+str(hp_max)

func _add_hp(value:int):
	var new_value = hp_current+value
	if(!new_value>hp_max):
		hp_current = new_value
	if(new_value<=0):
		hp_current = 0
		_reset()
		LevelLoader.goto_scene(
			"res://Levels/GameLevel.tscn",
			Vector2(0, 0),
			Vector2(0, 1)
			)
	_set_hp_text()

func _add_hp_max(value:int):
	var new_value = hp_max+value
	if(new_value<0):
		new_value = 0
	hp_max = new_value
	_add_hp(value)
