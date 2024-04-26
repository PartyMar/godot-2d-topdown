extends Node2D

@onready var item_area = $Item

func _ready():
	item_area.touch = Callable(self, "_touch_enter_house2")

func _touch_enter_house2():
	LevelLoader.goto_scene(
		"res://Levels/house_2.tscn",
		Vector2(56, 18),
		Vector2(0, -1)
		)
