extends Node2D


export(int) var type_id
export var prey_ids = []
export var predator_ids = []

var speed = 2
var velocity = Vector2()

var target = null
var initial_target_distance = 0


func _physics_process(delta):
	if target == null:
		target = find_target()
	elif not is_instance_valid(target):
		target = find_target()
	elif position.distance_to(target.position) > initial_target_distance * 2:
		target = find_target()
	
	if target != null:
		velocity = position.direction_to(target.position) * speed
		position += velocity
	
	for body in $Area2D.get_overlapping_areas():
		var hand = body.get_parent()
		if hand.type_id != type_id:
			if hand.type_id in prey_ids:
				eat(hand)
			if hand.type_id in predator_ids:
				hand.eat(self)


func eat(hand):
	var new_hand = self.duplicate()
	new_hand.position = hand.position
	hand.queue_free()
	get_parent().add_child(new_hand)


func find_target():
	target = get_parent().nearest(self, prey_ids)
	if target != null:
		initial_target_distance = position.distance_to(target.position)
	return target
