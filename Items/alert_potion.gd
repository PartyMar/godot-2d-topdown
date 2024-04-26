extends Sprite2D

@onready var item_area = $Item
@export var id:int = 0

func _ready():
	if(!LevelLoader.alerts[id]):
		queue_free()
	item_area.touch = Callable(self, "_touch_alert")

func _touch_alert():
	LevelLoader.alerts[id] = false
	LevelLoader.reset_doors()
	queue_free()
