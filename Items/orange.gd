extends Sprite2D

@onready var item_area = $Item
@export var id:int = 0

func _ready():
	if(!LevelLoader.oranges[id]):
		queue_free()
	item_area.touch = Callable(self, "_touch_orange")

func _touch_orange():
	UIManager._add_hp_max(1)
	LevelLoader.oranges[id] = false
	queue_free()
