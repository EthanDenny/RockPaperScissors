extends KinematicBody2D


export(int) var type_id
export var prey_ids = []

var speed = 0
var target = null


func _physics_process(delta):
	if target == null or target.type_id == type_id:
		find_target()
	
	if target != null and get_parent().simulate:
		var velocity = position.direction_to(target.position) * speed
		var collision = move_and_collide(velocity * delta)
		if collision:
			var hand = collision.collider
			if hand.type_id != type_id:
				if hand.type_id in prey_ids:
					eat(hand)
				if type_id in hand.prey_ids:
					hand.eat(self)


func eat(hand):
	hand.find_node("Sprite").texture = $Sprite.texture
	hand.type_id = type_id
	hand.prey_ids = prey_ids
	find_target()
	hand.find_target()


func find_target():
	target = get_parent().get_target(self, prey_ids)
