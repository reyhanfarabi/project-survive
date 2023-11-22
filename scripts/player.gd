extends CharacterBody2D

@export var entity: Resource_Entity
@export var speed: int = 200
@export var attack_cooldown: int = 2
@export var attack_animation: float = 0.5		# could be change later when animation is added

var can_attack: bool = true


func _ready():
	start()


func start():
	$AttackTimer.wait_time = attack_cooldown
	$AttackHitbox.hide()


func _physics_process(delta):
	var input = Input.get_vector("left", "right", "top", "down")
	handle_movement(input)
	handle_facing(input)
	handle_attack()


func handle_movement(input):
	velocity = speed * input
	move_and_slide()


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


func handle_attack():
	# check if possible to attack
	if not can_attack:
		return
	can_attack = false
	$AttackTimer.start()
	
	# handle show and hide attack hitbox
	$AttackHitbox.show()
	await get_tree().create_timer(0.5).timeout
	$AttackHitbox.hide()


func _on_attack_timer_timeout():
	can_attack = true


func _on_attack_hitbox_area_entered(area):
	if area.is_in_group("enemies"):
		print(area.entity.health)		# need to adjust later
