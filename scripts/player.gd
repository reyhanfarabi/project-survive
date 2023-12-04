extends CharacterBody2D


@export var _resource: Resource_Player
@export var _damage_shader_delay: float = 0.1

@onready var _game_camera_node: Camera2D = get_node("../GameCamera2D")

var _can_attack: bool = true


func _ready():
	_start()


func _start():
	$PlayerCamera2D.make_current()
	$AttackTimer.wait_time = _resource.attack_cooldown
	_resource.setup_level()


func _physics_process(_delta):
	var input = Input.get_vector("left", "right", "top", "down")
	_handle_character_facing(_get_mouse_lookat_vector())
	_handle_attack(_get_mouse_lookat_vector())
	_handle_destory()
	_collect_drops()


func _handle_character_facing(input):
	# handle horizontal facing
	if input.x > 0:
		get_node("Sprite2D").set_flip_h(false)
		
	elif input.x < 0:
		get_node("Sprite2D").set_flip_h(true)


func _handle_weapon_facing(look_at_vec):
	$Weapon/Sword.rotation = look_at_vec.angle()
	$Weapon/AttackCollisionShape.rotation = look_at_vec.angle()


func _handle_attack(look_at_vec):
	# handle where to attack
	_handle_weapon_facing(look_at_vec)
	
	# check if possible to attack
	if not _can_attack:
		return
	_can_attack = false
	$AttackTimer.start()
	
	# handle deal damage to all enemy inside the hitbox
	for area in $Weapon.get_overlapping_areas():
		if area.is_in_group("enemies"):
			area.deal_damage(_resource.attack_damage)


func _handle_destory():
	if _resource.health <= 0:
		_game_camera_node.position = position
		_game_camera_node.make_current()
		queue_free()


func _collect_drops():
	for area in $BodyArea.get_overlapping_areas():
		if area.is_in_group("drops"):
			_resource.update_level(area.exp_point)
			area.destroy()


func _get_mouse_lookat_vector():
	var center_viewport_position = get_viewport_rect().size / 2
	var mouse_position = get_viewport().get_mouse_position()
	return (mouse_position - center_viewport_position).normalized()


func deal_damage(damage_amount: int):
	$Sprite2D.material.set_shader_parameter("is_damage_taken", true)
	_resource.health -= damage_amount
	await get_tree().create_timer(_damage_shader_delay).timeout
	$Sprite2D.material.set_shader_parameter("is_damage_taken", false)


func _on_attack_timer_timeout():
	_can_attack = true
