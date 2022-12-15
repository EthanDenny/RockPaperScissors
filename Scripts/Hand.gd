extends Node2D


export(int) var type_id
export var prey_ids = []
export var predator_ids = []

var velocity = Vector2()


func _ready():
	velocity = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized() * 10


func _physics_process(delta):
	position += velocity
	
	for body in $Area2D.get_overlapping_areas():
		var mag = velocity.length()
		var dir = velocity.normalized() * rand_range(-1, 1)
		velocity = dir * mag
		
		var hand = body.get_parent()
		if hand.type_id != type_id:
			if hand.type_id in prey_ids:
				eat(hand)
			if hand.type_id in predator_ids:
				hand.eat(self)


func eat(hand):
	var new_hand = self.duplicate()
	new_hand.position = hand.position
	new_hand.velocity = hand.velocity
	hand.queue_free()
	get_parent().add_child(new_hand)
