extends CharacterBody2D


@export var speed = 200


func _physics_process(delta):
	var input = Input.get_vector("left", "right", "top", "down")
	handle_movement(input)
	handle_facing(input)
	pass


func handle_movement(input):
	velocity = speed * input
	move_and_slide()
	pass


func handle_facing(input):
	# handle vertical facing
	if input.y > 0:
		$Sprite2D.frame = 0
	elif input.y < 0:
		$Sprite2D.frame = 1
	
	# handle horizontal facing
	if input.x > 0:
		$Sprite2D.frame = 2
		get_node("Sprite2D").set_flip_h(true)
		$AttackHitbox.scale = Vector2(-1, 1)
		
	elif input.x < 0:
		$Sprite2D.frame = 2
		get_node("Sprite2D").set_flip_h(false)
		$AttackHitbox.scale = Vector2(1, 1)
	
	pass
