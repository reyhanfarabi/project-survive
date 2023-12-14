extends Node2D
class_name TakeDamageComponent


@export var _resource: Resource_Entity: set = set_resource
@export var _flicker_effect_comp: FlickerEffectComponent


func set_resource(res: Resource_Entity) -> void:
	_resource = res


func take_damage(damage_taken: int) -> void:
	_flicker_effect_comp.trigger_flicker()
	_resource.health -= damage_taken
