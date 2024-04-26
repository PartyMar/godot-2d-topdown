extends Sprite2D

@onready var item_area = $Item
@export var id:int = 0

func _ready():
	if(!LevelLoader.keys[id]):
		queue_free()
	item_area.touch = Callable(self, "_touch_key")

func _touch_key():
	UIManager._add_key(1)
	LevelLoader.keys[id] = false
	queue_free()
