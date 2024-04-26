extends Node2D

@onready var item_area = $Item

func _ready():
	item_area.touch = Callable(self, "_touch_enter_house1")

func _touch_enter_house1():
	LevelLoader.goto_scene(
		"res://Levels/house_1.tscn",
		Vector2(8, 35),
		Vector2(0, -1)
		)
