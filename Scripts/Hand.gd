extends Node

export(int) var type_id
export var prey_ids = []
export var predator_ids = []

var velocity = Vector2()


func _physics_process(delta):
	for body in $Area2D.get_overlapping_areas():
		var hand = body.get_parent()
		
		if hand.type_id in prey_ids:
			eat(hand)
		if hand.type_id in predator_ids:
			hand.eat(self)


func eat(hand):
	var new_hand = self.duplicate()
	new_hand.position = hand.position
	new_hand.velocity = hand.velocity
	get_parent().add_child(new_hand)
	hand.queue_free()
