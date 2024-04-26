extends Node2D

@onready var item_area = $Item

func _ready():
	item_area.touch = Callable(self, "_touch_exit_house1")

func _touch_exit_house1():
	LevelLoader.goto_scene(
		"res://Levels/GameLevel.tscn",
		Vector2(72, -57),
		Vector2(0, 1)
		)
