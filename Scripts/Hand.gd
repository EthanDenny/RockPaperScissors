extends Node2D


export(int) var type_id
export var prey_ids = []
export var predator_ids = []

var speed = 0
var target = null


func _physics_process(delta):
	if target == null:
		find_target()
	
	if target != null and target.type_id == type_id:
		find_target()
	
	if target != null:
		var velocity = position.direction_to(target.position) * speed
		position += velocity
	
	if speed > 0:
		for body in $Area2D.get_overlapping_areas():
			var hand = body.get_parent()
			if hand.type_id != type_id:
				if hand.type_id in prey_ids:
					eat(hand)
				if hand.type_id in predator_ids:
					hand.eat(self)


func eat(hand):
	hand.find_node("Sprite").texture = $Sprite.texture
	hand.type_id = type_id
	hand.prey_ids = prey_ids
	hand.predator_ids = predator_ids
	find_target()
	hand.find_target()


func find_target():
	target = get_parent().nearest(self, prey_ids)
