extends Area2D
class_name WeaponSwordComponent


@onready var _player_stats: Resource_Player = preload("res://resources/entity/player.tres")
@onready var _weapon_stats: Resource_Weapon = preload("res://weapons/Sword/sword.tres")

var _player_look_at_component: PlayerLookAtComponent
var _look_at_vec: Vector2
var _can_attack: bool = true


func _ready() -> void:
	$AttackDelayTimer.wait_time = _weapon_stats.attack_cooldown
	_player_look_at_component = get_node("../PlayerLookAtComponent")
	_update_player_look_at_vec()


func _process(_delta) -> void:
	_update_player_look_at_vec()
	_handle_aim()
	_handle_attack()


func _update_player_look_at_vec() -> void:
	if _player_look_at_component is PlayerLookAtComponent:
		_look_at_vec = _player_look_at_component.get_look_at()


func _handle_aim() -> void:
	rotation = _look_at_vec.angle()


func _handle_attack() -> void:
	# check if possible to attack
	if not _can_attack:
		return
	_can_attack = false
	$AttackDelayTimer.start()
	
	# handle deal damage to all enemy inside the hitbox
	for area in get_overlapping_areas():
		if area.is_in_group("enemies"):
			area.deal_damage(_calculate_attack_damage())


func _calculate_attack_damage() -> int:
	return _player_stats.attack_damage + _weapon_stats.attack


func _on_attack_delay_timer_timeout() -> void:
	_can_attack = true
