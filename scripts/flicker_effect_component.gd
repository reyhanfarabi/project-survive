extends Node2D
class_name FlickerEffectComponent


@export var _sprite: Sprite2D
var _FLICKER_DELAY: float = 0.1


func trigger_flicker() -> void:
	_sprite.material.set_shader_parameter("is_damage_taken", true)
	await get_tree().create_timer(_FLICKER_DELAY).timeout
	_sprite.material.set_shader_parameter("is_damage_taken", false)
