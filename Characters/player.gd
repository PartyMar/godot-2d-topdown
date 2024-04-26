class_name Player extends CharacterBody2D

#Move variables
@export var move_speed:float = 100
@export var starting_direction : Vector2 = Vector2(0, 0)
var face_adjusted:bool = false
#animation variables
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
#Interact variables
@onready var interact_area = $InteractArea/CollisionShape2D
@onready var all_interactions = []



func _process(_delta):
	if Input.is_action_pressed("Interact"):
		UIManager._set_text_message(_interact())
	
	#TODO fix that monstrocity 
	#Delay for initializing player
	if(face_adjusted): return
	elif(starting_direction == Vector2(0, 0)): return
	else:
		face_adjusted = true
		update_direction(starting_direction)

func _physics_process(_delta):
	#Get Input
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	
	_update_animation_parameters(input_direction)
	_update_interact_area_pos(input_direction)
	velocity = input_direction * move_speed
	
	#Move and Slide functions
	move_and_slide()
	_pick_new_state()


func _update_animation_parameters(move_input:Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)

func _update_interact_area_pos(move_input:Vector2):
	if(move_input != Vector2.ZERO):
		var area_pos = Vector2(0,0)
		if(move_input.x !=0):
			area_pos.x = 7*(move_input.x/abs(move_input.x))
		elif(move_input.y !=0):
			area_pos.y = 7*(move_input.y/abs(move_input.y))
		
		interact_area.position = area_pos

func _pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")

func update_direction(direction):
	_update_animation_parameters(direction)

#Interaction functions
###########################
func _on_interact_area_area_entered(area):
	all_interactions.insert(0, area)

func _on_interact_area_area_exited(area):
	all_interactions.erase(area)

func _interact():
	if(!all_interactions.is_empty()):
		return all_interactions[0].interact_label
	else:
		return ""
