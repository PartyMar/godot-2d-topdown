extends Sprite2D

@onready var item_area = $Item
@export var id:int = 0

func _ready():
	if(!LevelLoader.olives[id]):
		queue_free()
	item_area.touch = Callable(self, "_touch_olives")

func _touch_olives():
	LevelLoader.olives[id] = false
	UIManager._add_hp_max(-10)
	queue_free()
