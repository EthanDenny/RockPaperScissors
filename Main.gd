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
