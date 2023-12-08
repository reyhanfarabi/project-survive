extends CharacterBody2D


@export var _resource: Resource_Player
@export var _damage_shader_delay: float = 0.1

@onready var _game_camera_node: Camera2D = get_node("../GameCamera2D")


func _ready():
	_start()


func _start():
	$PlayerCamera2D.make_current()
	_resource.setup_level()


func _physics_process(_delta):
	_handle_destory()


func _handle_destory():
	if _resource.health <= 0:
		_game_camera_node.position = position
		_game_camera_node.make_current()
		queue_free()


func deal_damage(damage_amount: int):
	$Sprite2D.material.set_shader_parameter("is_damage_taken", true)
	_resource.health -= damage_amount
	await get_tree().create_timer(_damage_shader_delay).timeout
	$Sprite2D.material.set_shader_parameter("is_damage_taken", false)


func _on_collect_drops_component_trigger_drop_effect(drop) -> void:
	_resource.update_level(drop.exp_point)
