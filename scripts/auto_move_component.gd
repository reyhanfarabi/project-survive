extends Node2D
class_name AutoMoveComponent


@export var _target_distance_padding: int
@export var _sprite: Sprite2D


func move_towards_direction(direction: Vector2, speed: int, delta: float) -> void:
	get_parent().position += direction * speed * delta


func move_towards_position(target_position: Vector2, speed: int, delta: float) -> void:
	var direction = Vector2(target_position - get_parent().position).normalized()
	
	if (get_parent().position.distance_to(target_position) > _target_distance_padding):
		get_parent().position += direction * speed * delta
	
	_handle_sprite_facing(direction)


func _handle_sprite_facing(direction: Vector2) -> void:
	if direction.x > 0:
		_sprite.flip_h = false
	elif direction.x < 0:
		_sprite.flip_h = true
