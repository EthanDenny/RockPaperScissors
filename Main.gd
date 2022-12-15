extends Node2D


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
		add_child(new_hand)


func nearest(pos : Vector2, ids : Array):
	var nearest_no_type
	var nearest_with_type = null
	
	for child in get_children():
		var dist = pos.distance_to(child.position)
		var near_dist = pos.distance_to(nearest_no_type.position)
		var near_type_dist = pos.distance_to(nearest_with_type.position)
		
		if dist < near_dist:
			nearest_no_type = child
		if dist < nearest_with_type and child.type_id in ids:
			nearest_with_type = child
	
	if nearest_with_type == null:
		return nearest_no_type
	else:
		return nearest_with_type
