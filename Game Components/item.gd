class_name Item extends Area2D


var touch:Callable = func():
	pass


func _on_body_entered(_body):
	touch.call()

