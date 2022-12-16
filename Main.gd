extends Node2D


export var movement_speed = 64
var simulate = false

var hands = [
	"res://Scenes/Paper.tscn",
	"res://Scenes/Rock.tscn",
	"res://Scenes/Scissors.tscn",
]


func _process(delta):
	if Input.is_action_just_pressed("spawn"):
		randomize()
		hands.shuffle()
		var new_hand = load(hands[0]).instance()
		new_hand.position = get_global_mouse_position()
		new_hand.speed = movement_speed
		add_child(new_hand)
	if Input.is_action_just_pressed("toggle_simulate"):
		simulate = not simulate


func nearest(hand, ids : Array):
	var nearest_no_type = null
	var nearest_with_type = null
	
	var pos = hand.position
	
	for child in get_children():
		if child.type_id == hand.type_id: continue
		
		var dist = pos.distance_to(child.position)

		if nearest_no_type == null:
			nearest_no_type = child
		else:
			var near_dist = pos.distance_to(nearest_no_type.position)
			if dist < near_dist:
				nearest_no_type = child
		
		if nearest_with_type == null:
			nearest_with_type = child
		else:
			var near_dist = pos.distance_to(nearest_with_type.position)
			if dist < near_dist and child.type_id in ids:
				nearest_with_type = child
	
	if nearest_with_type == null:
		return nearest_no_type
	else:
		return nearest_with_type
