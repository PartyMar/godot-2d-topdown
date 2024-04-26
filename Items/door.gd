extends Sprite2D

@onready var item_area = $Item
@export var id:int = 0

func _ready():
	if(!LevelLoader.doors[id]):
		queue_free()
	item_area.touch = Callable(self, "_touch_door")

func _touch_door():
	var opened = UIManager._add_key(-1)
	if(opened):
		print("DOOR OPENED")
		LevelLoader.doors[id] = false
		queue_free()
	else:
		print("NEED KEY")
