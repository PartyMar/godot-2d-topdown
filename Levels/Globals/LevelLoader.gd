extends Node

#Save State of items
@export var keys = [true,true,true,true,true,true,true,true]
@export var apples = [true,true,true,true,true,true,true,true]
@export var oranges = [true,true,true,true,true,true,true,true]
@export var peppers = [true,true,true,true,true,true,true,true]
@export var olives = [true,true,true,true,true,true,true,true]
@export var alerts = [true,true,true,true,true,true,true,true]
@export var doors = [true,true]

#Door
var doors_pos = [Vector2(72,-61), Vector2(-119,-61)]
var door:String = "res://Items/door.tscn"

#Player
@export var player:String = "res://Characters/player.tscn"
var player_instance:Player
var player_pos_init:Vector2 = Vector2(0, 0)
var player_face_init:Vector2 = Vector2(0, 1)

func reset_items():
	for i in keys.size():
		keys[i] = true
	for i in apples.size():
		apples[i] = true
	for i in oranges.size():
		oranges[i] = true
	for i in peppers.size():
		peppers[i] = true
	for i in olives.size():
		olives[i] = true
	for i in doors.size():
		doors[i] = true


var current_scene = null
func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	_add_player()

func goto_scene(path, player_pos:Vector2, player_face:Vector2):
	player_pos_init = player_pos
	player_face_init = player_face
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	
	#Create player
	_add_player()


func _add_player():
	if(player_instance != null): player_instance.free()
	
	var p = load(player)
	player_instance = p.instantiate()
	
	current_scene.add_child(player_instance)
	
	player_instance.starting_direction = player_face_init
	player_instance.position = player_pos_init


func reset_doors():
	for i in doors.size():
		if(!doors[i]):
			doors[i] = true
			if(get_tree().current_scene.name == "MainLevel"):
				_create_door(i)

func _create_door(id:int):
	var d = load(door)
	var new_door = d.instantiate()
	current_scene.add_child(new_door)
	new_door.position = doors_pos[id]
