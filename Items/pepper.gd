extends Sprite2D

@onready var item_area = $Item
@export var id:int = 0

func _ready():
	if(!LevelLoader.peppers[id]):
		queue_free()
	item_area.touch = Callable(self, "_touch_pepper")

func _touch_pepper():
	LevelLoader.peppers[id] = false
	UIManager._add_hp(-1)
	queue_free()
