extends Node2D


export var movement_speed = 64
var simulate = false

var hands = [
	"res://Scenes/Paper.tscn",
	"res://Scenes/Rock.tscn",
	"res://Scenes/Scissors.tscn",
]


func _ready():
	randomize()


func _process(delta):
	if Input.is_action_just_pressed("spawn"):
		var chosen_hand = hands[randi() % len(hands)]
		var new_hand = load(chosen_hand).instance()
		new_hand.position = get_global_mouse_position()
		new_hand.speed = movement_speed
		add_child(new_hand)
	if Input.is_action_just_pressed("toggle_simulate"):
		simulate = not simulate


# Checks if all the hands are the same type
func all_same_type():
	var check_type = get_child(0).type_id
	for child in get_children():
		if child.type_id != check_type: return false
	return true

# Finds the nearest hand to the given hand,
# which will have one of the ids in the list
# if a list is provided
func find_nearest_to(hand, ids = []):
	var nearest_hand = null
	var pos = hand.position
	
	for child in get_children():
		if child.type_id == hand.type_id: continue
		
		if nearest_hand == null:
			nearest_hand = child
		else:
			var dist = pos.distance_to(child.position)
			var near_dist = pos.distance_to(nearest_hand.position)
			
			if dist < near_dist and (ids == [] or child.type_id in ids):
				nearest_hand = child
	
	return nearest_hand

# Finds an appropriate target for the given hand,
# and also uses the oppurtunity to check whether
# the simulation should be paused
func get_target(hand, ids = []):
	if all_same_type():
		simulate = false
	
	var nearest_hand = find_nearest_to(hand, ids)
	if nearest_hand == null:
		nearest_hand = find_nearest_to(hand)
	
	return nearest_hand
