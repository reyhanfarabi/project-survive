extends CharacterBody2D


@export var _entity: Resource_Entity
@export var _speed: int = 200
@export var _attack_cooldown: int = 2

@onready var _game_camera_node: Camera2D = get_node("../GameCamera2D")

var _can_attack: bool = true


func _ready():
	_start()


func _start():
	$PlayerCamera2D.make_current()
	$AttackTimer.wait_time = _attack_cooldown
	$AttackHitbox.hide()


func _physics_process(_delta):
	_game_camera_node.position = position
	var input = Input.get_vector("left", "right", "top", "down")
	_handle_movement(input)
	_handle_facing(input)
	_handle_attack()
	_handle_destory()


func _handle_movement(input):
	velocity = _speed * input
	move_and_slide()


func _handle_facing(input):
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


func _handle_attack():
	# check if possible to attack
	if not _can_attack:
		return
	_can_attack = false
	$AttackTimer.start()
	
	# handle deal damage to all enemy inside the hitbox
	for area in $AttackHitbox.get_overlapping_areas():
		if area.is_in_group("enemies"):
			area.deal_damage(_entity.attack_damage)


func _handle_destory():
	if _entity.health <= 0:
		_game_camera_node.position = position
		_game_camera_node.make_current()
		queue_free()


func deal_damage(damage_amount: int):
	_entity.health -= damage_amount
	print(_entity.health)


func _on_attack_timer_timeout():
	_can_attack = true
